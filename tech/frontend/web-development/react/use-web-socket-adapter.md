```tsx
import { Logger } from "logic/internals/logging/logger";
import { EnvironmentVariables } from "logic/internals/runtime/environment-variables";
import { useMemo } from "react";
import { z } from "zod";

type WasClosed = { by: "error" } | { by: "participant" };

export function useMainApiWebSockerAdapter() {
  return useMemo(() => {
    return {
      createAdapter: async <S extends z.ZodType<unknown>>(args: {
        path: string;
        messageSchema: S;
        onClose: (wasClosed: WasClosed) => void;
        onMessage: (message: z.TypeOf<S>) => void;
        onInvalidMessageReceived: () => void;
      }) => {
        const webSocket = new WebSocket(
          `${EnvironmentVariables.MAIN_API_SOCKET_URL}${args.path}`
        );

        const messageListener = (e: MessageEvent) => {
          let unknownMessage: unknown;

          try {
            unknownMessage = JSON.parse(e.data as string) as unknown;
          } catch (err) {
            Logger.logError(
              "use-main-api-web-socket:receive-message:invalid-json",
              err
            );

            return;
          }

          const messageValidation = z
            .object({ message: z.string() })
            .safeParse(unknownMessage);

          if (!messageValidation.success) {
            Logger.logError(
              "use-main-api-web-socket:receive-message:invalid-data",
              messageValidation.error
            );

            args.onInvalidMessageReceived();

            return;
          }

          args.onMessage(messageValidation.data);
        };

        webSocket.addEventListener("message", messageListener);

        const errorListener = () => {
          args.onClose({ by: "error" });
        };

        webSocket.addEventListener("error", errorListener);

        const closeListener = () => {
          args.onClose({ by: "participant" });
        };

        webSocket.addEventListener("close", closeListener);

        await new Promise((resolve) => {
          const openListener = () => {
            window.removeEventListener("open", openListener);
            resolve(undefined);
          };
          webSocket.addEventListener("open", openListener);
        });

        return {
          sendMessage: () => {
            throw new Error("not implemented");
          },
          close: () => {
            webSocket.removeEventListener("message", messageListener);
            webSocket.removeEventListener("error", errorListener);
            webSocket.removeEventListener("close", closeListener);
            webSocket.close();
          },
        };
      },
    };
  }, []);
}
```