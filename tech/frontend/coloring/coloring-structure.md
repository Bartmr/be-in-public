## Coloring structure

A project has many fill colors. Fill colors have many colors that contrast with the fill color. These contrasting colors will be used for text and strokes inside shapes where the background uses their parent fill color.

Example:

```json
{
  "body": {
    "value": "white",
    "contrastingColors": {
      "body": {
        "value": "black"
      },
      "primary": {
        "value": "darkblue"
      },
      "secondary": {
        "value": "darkorange"
      }
    }
  },
  "primary": {
    "value": "darkblue",
    "contrastingColors": {
      "body": {
        "value": "white"
      },
      "primary": {
        "value": "lightblue"
      },
      "secondary": {
        "value": "yellow"
      }
    }
  },
  "secondary": {
    "value": "yellow",
    "contrastingColors": {
      "body": {
        "value": "black"
      },
      "primary": {
        "value": "darkblue"
      },
      "secondary": {
        "value": "darkorange"
      }
    }
  }
}
```

### Tailwind

In Tailwind, you can set a similar structure by setting the following in the config

```js
module.exports = {
  theme: {
    colors: {
      body: 'white',
      'body-in-body': 'black',
      'primary-in-body': 'darkblue',
      'secondary-in-body': 'darkorange',
      //
      primary: 'darkblue',
      'body-in-primary': 'white',
      'primary-in-primary': 'lightblue',
      'secondary-in-primary': 'yellow',
      //
      secondary: 'yellow',
      'body-in-secondary': 'black',
      'primary-in-secondary': 'darkblue',
      'secondary-in-secondary': 'darkorange'
    }
  }
}
```

Which will generate a bunch of CSS classes following this convention: `{contrasting color}-in-{fill color}`

Then, using React components, you can inform the component about what color surrounds it, through props

```tsx
function Text(props: {
  inColor: 'body' | 'primary' | 'secondary'
}) {
  return <p
    className={`text-primary-in-${props.inColor}`}
  ></p>
}
```

Consider naming the colors `one`, `two`, ... in order to keep shorter names, and no class name collisions with built-in Tailwind classes.

### Mantine

Same as Tailwind

### Bootstrap

Look at `tech/frontend/web-development/bootstrap/5.1-auto-contrast`

### React Native

Serve the color structure as an object, through a React hook.

### Ant Design

#### Option 1

Ant Design doesn't need too much to contrasting colors while developing. You will only need to care and use contrasting colors on your own on the rare occasion that you fill the background with a strong opaque color, which is not frequent if you use purely Ant Design and not any custom component.

```tsx
import { theme } from "antd";
import { GlobalToken } from "antd/es/theme/interface";
import tinyColor from "tinycolor2";

type AppColorKey = "Neutral" | "Info" | "Success" | "Warning" | "Error";

type AppGlobalTokenColorKey = `color${AppColorKey}In${AppColorKey}`;

type AppToken = GlobalToken & {
  [K in AppGlobalTokenColorKey]: string;
};

const getContrastingTokens = (
  inColorName: AppColorKey,
  token: GlobalToken,
  inColorString: string
) => {
  const inColor = tinyColor(inColorString);

  return {
    [`colorNeuralIn${inColorName}`]: inColor.isDark()
      ? token.colorBgBase
      : token.colorTextBase,
    [`colorInfoIn${inColorName}`]: token.colorInfo,
    [`colorSuccessIn${inColorName}`]: token.colorSuccess,
    [`colorWarningIn${inColorName}`]: token.colorWarning,
    [`colorErrorIn${inColorName}`]: token.colorError,
  };
};

export function useToken(): AppToken {
  const { token } = theme.useToken();

  return {
    ...token,
    ...getContrastingTokens("Neutral", token, token.colorBgBase),
    ...getContrastingTokens("Info", token, token.colorInfo),
    ...getContrastingTokens("Success", token, token.colorSuccess),
    ...getContrastingTokens("Warning", token, token.colorWarning),
    ...getContrastingTokens("Error", token, token.colorError),
  } as AppToken;
}
```

#### Option 2

Instead of augmenting the token, you apply contrasting colors right where you need them, by calling a function.

Pro: it becomes more flexible to get contrasting colors for any color, not just the ones defined in the app theme.

```tsx
import tinyColor from 'tinycolor2'

export function useContrastingColors() {
  const get = (dominantColor: string) => {
    const _dominantColor = tinyColor(dominantColor);

    const lightColors = {
      neutral: '#fff',
      primary: '#fff',
      info: '#fff',
      success: '#fff',
      warning: '#fff',
      error: '#fff',
    }

    const darkColors = {
      neutral: '#000',
      primary: '#000',
      info: '#000',
      success: '#000',
      warning: '#000',
      error: '#000',
    }

    return _dominantColor.isDark() ? lightColors: darkColors
  }

  return {
    get
  }
}
```

```tsx
import { theme } from "antd";
import { useContrastingColors } from "./contrasting-colors"

export function Component() {
  const { token }  = theme.useToken()

  const contrastingColors = useContrastingColors()

  return <div style={{ backgroundColor: token.colorPrimary }}>
    <p style={{
      color: contrastingColors.get(token.colorPrimary).neutral
    }}>
      Text
    </p>
  </div>
}
```