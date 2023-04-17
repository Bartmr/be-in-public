```tsx
function Modal(props: { children: ReactNode }) {
  // ...
}

function ModalHeader() {
  // ...
}

function ModalBody() {
  // ...
}

Modal.Header = ModalHeader;
Modal.Body = ModalBody;

export {
  Modal
}

//
//

<Modal>
  <Modal.Header></Modal.Header>
  <Modal.Body></Modal.Body>
<Modal>

```

```tsx
function Paragraph(props: { children: ReactNode }) {
  return <p>{props.children}</p>
}

function Bold(props: { children: ReactNode }) {
  return <span className="fw-bold">{props.children}</span>
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