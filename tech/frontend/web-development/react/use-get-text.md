```tsx
import { template } from "lodash";
import { useCallback } from "react";

const TEXT = {
  test: "test",
  testFn: template("hello <%= arg %>!"),
};

export function useGetText() {
  return useCallback(
    <K extends keyof typeof TEXT>(key: K, args?: { [key: string]: string }) => {
      const text = TEXT[key];

      if (typeof text === "string") {
        return text;
      } else {
        return text(args);
      }
    },
    []
  );
}
```