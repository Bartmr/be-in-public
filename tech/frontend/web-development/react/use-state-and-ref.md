```tsx
import { useCallback, useRef, useState } from "react";

export function useStateAndRef<State>(initialState: State) {
  const [state, _setState] = useState(initialState);
  const stateRef = useRef(initialState);

  const setState = useCallback((newState: State) => {
    _setState(newState);
    stateRef.current = newState;
  }, []);

  return [state, stateRef, setState] as const;
}
```