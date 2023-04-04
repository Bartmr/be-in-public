```tsx
import { Logger } from "logic/internals/logging/logger";
import { EnvironmentVariables } from "logic/internals/runtime/environment-variables";
import { useEffect, useState } from "react";
import { z } from "zod";

type Props<S extends z.ZodType<unknown>> = {
  path: string;
  messageSchema: S;
};

type WasClosed = { by: "error" } | { by: "participant" };

type ReturnValue<S extends z.ZodType<unknown>> = {
  wasClosed: undefined | WasClosed;
  invalidMessageWasReceived: boolean;
  lastMessage?: z.TypeOf<S>;
  sendMessage: undefined | (() => void);
};

export function useMainApiWebSocket<S extends z.ZodType<unknown>>(
  props: Props<S>
): ReturnValue<S> {
  const [wasConnected, setWasConnected] = useState(false);
  const [wasClosed, setWasClosed] = useState<undefined | WasClosed>();

  const [invalidMessageWasReceived, setInvalidMessageWasReceived] =
    useState(false);
  const [lastMessage, setLastMessage] = useState<z.TypeOf<S> | undefined>(
    undefined
  );

  const [webSocket, setWebSocket] = useState<WebSocket | undefined>();

  useEffect(() => {
    const webSocket = new WebSocket(
      `${EnvironmentVariables.MAIN_API_SOCKET_URL}${props.path}`
    );

    setWebSocket(webSocket);

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

        setInvalidMessageWasReceived(true);

        return;
      }

      setLastMessage(messageValidation.data);
    };

    webSocket.addEventListener("message", messageListener);

    const errorListener = () => {
      setWasClosed({ by: "error" });
    };

    webSocket.addEventListener("error", errorListener);

    const closeListener = () => {
      setWasClosed({ by: "participant" });
    };

    webSocket.addEventListener("close", closeListener);

    const openListener = () => {
      setWasConnected(true);
    };
    webSocket.addEventListener("open", openListener);

    return () => {
      webSocket.removeEventListener("message", messageListener);
      webSocket.removeEventListener("error", errorListener);
      webSocket.removeEventListener("close", closeListener);
      webSocket.removeEventListener("close", openListener);
      webSocket.close();

      setWasClosed(undefined);
      setInvalidMessageWasReceived(false);
      setLastMessage(undefined);
      setWebSocket(undefined);
    };
  }, [props.path, props.messageSchema]);

  const sendMessage = useMemo(() => {
    if(webSocket && wasConnected && !wasClosed) {
      return () => {
            throw new Error("not implemented");
          }
    } else {
      return undefined
    }
  }, [webSocker, wasConnected, wasClosed])

  return {
    lastMessage,
    wasClosed,
    invalidMessageWasReceived,
    sendMessage,
  };
}
```