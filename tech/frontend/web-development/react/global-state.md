```typescript
import React, { MutableRefObject, ReactNode, useContext, useMemo } from "react"
import { useStateAndRef } from "./logic/internals/utils/use-state-and-ref"
import { throwError } from "./logic/internals/utils/throw-error"

type GlobalState = Partial<{

}>

type GlobalStateContextValue = {
  globalState: GlobalState,
  globalStateRef: MutableRefObject<GlobalState>,
  setGlobalState: (newState: GlobalState) => void
}


const GlobalStateContext = React.createContext<null | GlobalStateContextValue>(null)

export function GlobalStateProvider(props: { children: ReactNode }) {
  const [globalState, globalStateRef, setGlobalState] = useStateAndRef<GlobalState>({})

  return <GlobalStateContext.Provider value={useMemo(() => ({
    globalState,
    globalStateRef,
    setGlobalState
  }), [globalState, globalStateRef, setGlobalState])}>{
    props.children
  }</GlobalStateContext.Provider>
}

export function useGlobalState() {
  return useContext(GlobalStateContext) || throwError()
}
```