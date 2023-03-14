```tsx
type State = {
  isLoading?: boolean;
  error?: TransportFailure;
  data?: { id: string }
}

function usePageLogic() {
  const [state, stateRef, _setState] = useStateAndRef<State>({})

  const setState = useCallback((nextState: State) => {
    /*
      Condition that checks if this next state is still relevant in the user flow

      Example:
      is this next state still related to what the user has on the screen?
    */
   if(nextState.data?.id !== stateRef.data?.id) {
    return
   }

   _setState(nextState)
  }, [state, stateRef, _setState])

  const doAsyncAction = useCallback(() => {
    setState({ isLoading: true })

    const response = await asyncAction();

    setState({ data: response })
  }, [state, setState])

  return {
    state,
  }
}
```