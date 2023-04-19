```tsx
type AuthSession = {
  loading?: boolean;
  error?: TransportFailure;
  data?: { user: User } | "not-logged-in"
};

type AuthStateContextValue = {
  session: AuthSession;
  sessionRef: MutableRefObject<AuthSession>;
  setSession: (
    nextValue: AuthSession
  ) => void;
};

const AuthStateContext = createContext<null | AuthStateContextValue>(null);

export function AuthStateProvider(props: { children: ReactNode }) {
  const [session, sessionRef, setSession] = useStateAndRef<AuthSession>({});

  const contextValue = useMemo((): AuthStateContextValue => {
    return {
      session,
      sessionRef,
      setSession,
    };
  }, [session, sessionRef, setSession]);

  return (
    <AuthStateContext.Provider value={contextValue}>
      {props.children}
    </AuthStateContext.Provider>
  );
}

export function useAuthState() {
  return useContext(AuthStateContext) || throwError();
}

```

```tsx
export function AuthEffects(props: { children: ReactNode }) {
  const analytics = useAnalytics();

  const { sessionRef, setSession } = useAuthState();

  const localStorage = useLocalStorage();
  const sessionStorage = useSessionStorage();

  const continueLogout = useCallback(async () => {
    if (!sessionRef.current.data) {
      return;
    }

    setSession({
      loading: true
    });

    /*
      ... Async stuff
    */

    localStorage.wipeAll();
    sessionStorage.wipeAll();

    setSession({ data: "not-logged-in" })
  }, [localStorage, sessionRef, sessionStorage, setSession]);

  useEffect(() => {
    const firebaseAuth = getFirebaseAuth();
    const listener = firebaseAuth.onAuthStateChanged(
      (user) => {
        (async () => {
          if (user) {
            if (
              sessionRef.current.data === "not-logged-in" ||
              sessionRef.current.data?.user.uid !== user.uid
            ) {
              analytics.identify({
                firebaseId: user.uid,
                email: user.email ?? undefined,
              });

              setSession({
                data: {
                  user,
                },
              });
            }
          } else {
            if (!sessionRef.current.data) {
              setSession({ data: "not-logged-in" });
            } else {
              continueLogout();
            }
          }
        })();
      },
      (error: unknown) => {
        Logger.logError("FrameWithState:onAuthStateChanged:error", error);

        setSession({
          ...sessionRef.current,
          error: TransportFailure.UnexpectedResponse
        });
      }
    );

    return () => {
      listener();
    };
  }, [
    continueLogout,
    localStorage,
    sessionRef,
    setSession,
    analytics,
  ]);

  return <>{props.children}</>;
}
```
```tsx
export type AuthenticatedGateRules = {
  access: "allow" | "block";
  hrefToRedirectTo?: string;
};

type Props = {
  rule: AuthenticatedGateRules;
  children: ReactNode;
};

export function AuthenticationGate(props: Props) {
  const { session } = useAuthState()

  if (!session.data) {
    return (
      <></>
    );
  } else {
    if (props.rule.access === "allow") {
      if (session.data) {
        return <>{props.children}</>;
      } else {
        return (
          <Redirect
            href={
              props.rule.hrefToRedirectTo ||
              LOGIN_ROUTE.getHref({ next: getCurrentLocalHref() })
            }
          />
        );
      }
    } else if (props.rule.access === "block") {
      if (session.data) {
        const searchParams = new URLSearchParams(window.location.search);

        const next = searchParams.get('next');

        return (
          <Redirect
            href={
              props.rule.hrefToRedirectTo ||
              (next && !next.startsWith(window.location.pathname)
                ? next
                : undefined) ||
              INDEX_ROUTE.getHref()
            }
          />
        );
      } else {
        return <>{props.children}</>;
      }
    } else {
      throw new Error()
    }
  }
}
```