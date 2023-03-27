```tsx
type ContextValue = {
  background: 'is-light' | 'is-dark'
}

const Context = createContext<ContextValue>({ background: 'is-light' })

export function NewBackground(props: {
  backgroundColor: string,
  children: ReactNode
}) {
  const parentContext = useContext(Context)

  const background = (() => {
    const color = tinyColor(props.backgroundColor)

    if(color.getAlpha() < 0.5) {
      return previousContext.background
    } else if (color.isDark()) {
      return 'is-dark'
    } else {
      return 'is-light'
    }
  })()

return <Context.Provider value={useMemo(() => ({background}), [background])}>
  {props.children}
  </Context.Provicer>
}

export function useContrastingColors() {
  const backgroundContext = useContext(Context) || throwError()

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

  return backgroundContext === 'is-dark' ? lightColors : darkColors
}
```