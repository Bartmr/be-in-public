## Method 1: Load all translations with an regular module import and inject them through the page / screen template

```tsx
const COMPONENT_EN_US_TEXT = {
  text1: 'Text 1',
  text2: ({ param }: { param: number }) => `Text ${param}`
}
```
```tsx
const COMPONENT_PT_BR_TEXT = {
  text1: 'Texto 1',
  text2: ({ param }: { param: number }) => `Texto ${param}`
}
```
```tsx
export function Component(props: {
  text: typeof COMPONENT_EN_US_TEXT
}) {
  return <>
    {props.text.text1}
    {props.text.text2({ param: 2 })}
  </>
}
```
```tsx
export function PageTemplate(props: {
  text: {
    component1: typeof COMPONENT_EN_US_TEXT
  }
}) {
  return <Component text={props.text.component1}>
}
```
```tsx
export function PageEnUs() {
  return <PageTemplate text={{ component1: COMPONENT_EN_US_TEXT }}>
}
```
```tsx
export function PagePtBr() {
  return <PageTemplate text={{ component1: COMPONENT_PT_BR_TEXT }}>
}
```

## Method 2

- See `tech/frontend/web-development/react/use-get-text.md`