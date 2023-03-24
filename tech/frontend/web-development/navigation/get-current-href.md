```ts
export function getCurrentHref() {
  return window.location.href.replace(window.location.origin, '');
}
```