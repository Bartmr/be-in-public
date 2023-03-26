```tsx
function Paragraph(props: { children: ReactNode }) {
  return <Text style={{ ...baseStyle }}>{props.children}</p>
}

function Bold(props: { children: ReactNode }) {
  return <Text style={{ ...variantStyle }}>{props.children}</Text>
}

Paragraph.Bold = Bold;

export {
  Paragraph
}

//
//

<Paragraph>
  Regular text
  <Paragraph.Bold>Bold Text</Paragraph.Bold>
</Paragraph>

```