```tsx
import { theme } from "antd";
import tinyColor from "tinycolor2";

export function useContrastingColors() {
  const { token } = theme.useToken();

  const get = (dominantColor: string) => {
    const _dominantColor = tinyColor(dominantColor);

    const lightColors = {
      neutral: token.colorBgBase,
      primary: token.colorPrimary,
      info: token.colorInfo,
      success: token.colorSuccess,
      warning: token.colorWarning,
      error: token.colorError,
    };

    const darkColors = {
      neutral: token.colorTextBase,
      primary: token.colorPrimary,
      info: token.colorInfo,
      success: tinyColor(token.colorSuccess).darken(5),
      warning: token.colorWarning,
      error: token.colorError,
    };

    return _dominantColor.isDark() ? lightColors : darkColors;
  };

  return {
    get,
  };
}

```