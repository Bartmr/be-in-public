```tsx
import { useCallback } from "react";

export function useHomeRoute() {
  /*
    Example: React Navigation for React Native
  */
  const { navigate } = useNavigation();

  return {
    getHref: useCallback((param: string) => '/home', []),
    navigate: useCallback((param: string) => navigate('home', { param }), [])
  }
}
```

```tsx
export const HOME_ROUTE = {
  path: "/home",
  getHref: (parameter: string) => `${SUMMARY_ROUTE.path}/${parameter}`,
  getHrefWithOrigin: (parameter: string) =>
    `${location.origin}${HOME_ROUTE.getHref(parameter)}`,
};

```