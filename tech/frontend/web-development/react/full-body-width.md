```tsx
import { ReactNode } from "react";

export function FullBodyHeight(props: { children: ReactNode }) {
  return (
    <>
      <style jsx global>{`
        body,
        #__next {
          height: 100%;
        }
      `}</style>
      {props.children}
    </>
  );
}
```