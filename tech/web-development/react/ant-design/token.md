## Token

```tsx
import { theme } from "antd";
import { GlobalToken, OverrideToken } from "antd/es/theme/interface";

export function useToken() {
  return theme.useToken().token as GlobalToken & OverrideToken;
}
```

## Extra token

```tsx
export function useExtraToken() {
  return {
    boxShadowLeft:
      "rgb(0 0 0 / 10%) -1px 0px 2px 0px, rgb(0 0 0 / 10%) -1px 0px 2px -1px, rgb(0 0 0 / 10%) -1px 0px 2px 0px",
  };
}
```