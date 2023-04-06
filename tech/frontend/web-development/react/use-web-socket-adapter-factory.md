```tsx
import { Logger } from "logic/internals/logging/logger";
import { EnvironmentVariables } from "logic/internals/runtime/environment-variables";
import { useMemo } from "react";
import { z } from "zod";

type WasClosed = { by: "error" } | { by: "server" };

export type MainApiWebSocketAdapter = {
  sendMessage: () => never;
  close: () => void;
};

export function useMainApiWebSocketAdapterFactory() {
  return useMemo(() => {
    return {
      createAdapter: async <S extends z.ZodType<unknown>>(args: {
        path: string;
        messageSchema: S;
        onClose: (wasClosed: WasClosed) => void;
        onMessage: (message: z.TypeOf<S>) => void;
        onInvalidMessageReceived: () => void;
      }): Promise<MainApiWebSocketAdapter> => {
        const webSocket = new WebSocket(
          `${EnvironmentVariables.MAIN_API_SOCKET_URL}${args.path}`
        );

        const messageListener = (e: MessageEvent) => {
          let unknownMessage: unknown;

          try {
            unknownMessage = JSON.parse(e.data as string) as unknown;
          } catch (err) {
            Logger.logError(
              "use-main-api-web-socket-adapter:receive-message:invalid-json",
              err
            );

            return;
          }

          const messageValidation = z
            .object({ message: z.string() })
            .safeParse(unknownMessage);

          if (!messageValidation.success) {
            Logger.logError(
              "use-main-api-web-socket-adapter:receive-message:invalid-data",
              messageValidation.error
            );

            args.onInvalidMessageReceived();

            return;
          }

          args.onMessage(messageValidation.data);
        };

        webSocket.addEventListener("message", messageListener);

        const errorListener = () => {
          removeListeners();

          Logger.logError(
            "use-main-api-web-socket-adapter:error-listener",
            new Error()
          );
          args.onClose({ by: "error" });
        };

        webSocket.addEventListener("error", errorListener);

        const closeListener = () => {
          removeListeners();

          args.onClose({ by: "server" });
        };

        webSocket.addEventListener("close", closeListener);

        const removeListeners = () => {
          webSocket.removeEventListener("message", messageListener);
          webSocket.removeEventListener("error", errorListener);
          webSocket.removeEventListener("close", closeListener);
        };

        await new Promise((resolve) => {
          /*
            SUCCESSFUL CONNECTION
          */
          const openListener = () => {
            window.removeEventListener("open", openListener);
            window.addEventListener("error", errorListener);

            resolve(undefined);
          };
          webSocket.addEventListener("open", openListener);

          /*
            FAILED CONNECTION
          */
          const errorOnStartListener = () => {
            Logger.logError(
              "use-main-api-web-socket-adapter:error-listener",
              new Error()
            );

            window.removeEventListener("error", errorOnStartListener);
            args.onClose({ by: "error" });

            resolve(undefined);
          };
          webSocket.addEventListener("error", errorOnStartListener);
        });

        return {
          sendMessage: () => {
            throw new Error("not implemented");
          },
          close: () => {
            removeListeners();

            webSocket.close();
          },
        };
      },
    };
  }, []);
}
```