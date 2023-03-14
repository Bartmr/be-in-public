```tsx
import { useMemo } from "react";
import { z } from "zod";

class LocalStorage {
  getItem<S extends z.ZodType<unknown>>(schema: S, key: string): z.TypeOf<S> {
    const data = window.localStorage.getItem(key);

    const validationResult = schema.parse(data ? JSON.parse(data) : undefined);

    return validationResult;
  }

  setItem(key: string, value: unknown): void {
    window.localStorage.setItem(key, JSON.stringify(value));
  }

  removeItem(key: string): void {
    window.localStorage.removeItem(key);
  }

  wipeAll(): void {
    window.localStorage.clear();
  }
}

export function useLocalStorage() {
  return useMemo(() => new LocalStorage(), []);
}
```