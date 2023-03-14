```tsx
import { useRef } from "react";

export function useQueue() {
  const promiseRef = useRef<Promise<void>>(Promise.resolve());

  return {
    run: async (cb: () => Promise<void>) => {
      const toWait = promiseRef.current;
      promiseRef.current = (async () => {
        await toWait;
        await cb();
      })();
    },
  };
}

```