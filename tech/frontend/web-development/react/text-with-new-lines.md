```tsx
import { ReactNode } from "react";

export function TextWithNewLines(props: { children: ReactNode }) {
  return (
    <span className="text-with-new-lines">
      <style jsx>
        {`
          .text-with-new-lines {
            overflow: initial;
            white-space: break-spaces;
          }
        `}
      </style>
      {props.children}
    </span>
  );
}
```