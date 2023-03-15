Have a component define the color in which nested components are placed, throught the use of something like React Context.

Example:

```tsx
type ThemeColor = "primary" | "secondary"

function ContrastWith(props: { color: ThemeColors | "inherit" }) {
    // ...
}

<div className="bg-primary">
  <ContrastWith color="primary">
    <Paragraph>
      Some text
    </Paragraph>
    <Checkbox
      label="click here">
  </ContrastWith>
</div>
```

If the web framework you are using does not support injecting context into nested components, you'll just have to set the dominant background color yourself in each component call.

Example:

```tsx

type ThemeColor = "primary" | "secondary"

export function Paragraph: (props: { contrastWith: ThemeColor | 'inherit' }) {
  //...
}

<div className="bg-primary">
  <Paragraph contrastWith="primary">Text 1</Paragraph>
  <Paragraph contrastWith="primary">Text 2</Paragraph>
<div>

```