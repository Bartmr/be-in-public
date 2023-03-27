```tsx
type OnEventSpec<S extends z.ZodType<unknown>> = {
  event: string;
  schema: S;
  callback: (data: S) => void;
};

type Unsubscribe = () => void;

type MainApiSocket = {
  on: <S extends z.ZodType<unknown>>(eventSpec: OnEventSpec<S>) => Unsubscribe;
};

const Context = createContext<MainApiSocket | null>(null);

export function MainApiSocketProvider(props: { children: ReactNode }) {
  const authState = useAuthState();

  const [client, setClient] = useState<{
    userId?: string;
    instance?: Socket;
  }>({});

  /* --- */
  /* --- */
  /* --- */

  const onEventSpecs = useMemo(
    () => new Set<OnEventSpec<z.ZodType<unknown>>>(),
    []
  );

  const subscribeToOnEvent = useCallback(
    <S extends z.ZodType<unknown>>({
      ioInstance,
      eventSpec,
    }: {
      ioInstance: Socket;
      eventSpec: OnEventSpec<S>;
    }) => {
      ioInstance.on(eventSpec.event, (data) => {
        const validationResult = eventSpec.schema.safeParse(data);

        if (!validationResult.success) {
          Logger.logError("main-api-socket", new Error(), {
            event: eventSpec.event,
            validationResult: validationResult.error,
          });
        } else {
          eventSpec.callback(
            // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-explicit-any
            validationResult.data as any
          );
        }
      });
    },
    []
  );

  /* --- */
  /* --- */
  /* --- */

  useEffect(() => {
    if (authState.session.data?.user.uid === client.userId) {
      return;
    }

    if (client.instance) {
      client.instance.disconnect();
    }

    /*
      Do not make a socket available when switching in between sessions
    */
    if (!authState.session.data) {
      setClient({});
    } else {
      const ioInstance = io(EnvironmentVariables.MAIN_API_SOCKET_URL, {
        auth: {
          token: authState.session.data.user.uid,
        },
      });

      onEventSpecs.forEach((eventSpec) => {
        subscribeToOnEvent({
          ioInstance,
          eventSpec,
        });
      });

      setClient({
        userId: authState.session.data.user.uid,
        instance: ioInstance,
      });
    }
  }, [
    authState.session,
    client.userId,
    client.instance,
    onEventSpecs,
    subscribeToOnEvent,
  ]);

  /* --- */
  /* --- */
  /* --- */

  const onEvent: MainApiSocket["on"] = useCallback(
    (eventSpec) => {
      // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-explicit-any
      onEventSpecs.add(eventSpec as any);

      if (client.instance) {
        subscribeToOnEvent({
          ioInstance: client.instance,
          eventSpec,
        });
      }

      return () => {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-argument, @typescript-eslint/no-explicit-any
        onEventSpecs.delete(eventSpec as any);

        if (client.instance) {
          client.instance.off(eventSpec.event, eventSpec.callback);
        }
      };
    },
    [client.instance, onEventSpecs, subscribeToOnEvent]
  );

  /* --- */
  /* --- */
  /* --- */

  return (
    <Context.Provider
      value={useMemo(() => {
        return {
          on: onEvent,
        };
      }, [onEvent])}
    >
      {props.children}
    </Context.Provider>
  );
}

export function useMainApiSocket() {
  return useContext(Context) ?? throwError();
}

```