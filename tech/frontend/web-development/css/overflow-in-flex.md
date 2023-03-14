```tsx
<div className="d-flex flex-column" style={{ position: "relative" }}>
  <div className={`sticky-top p-3 bg-primary-weak-1`}>
    <h2 className="h6">Text</h2>
  </div>
  <div
    style={{
      minHeight: 0,
      flex: 1,
      display: "flex",
      flexDirection: "column",
    }}
  >
    <div
      style={{
        flex: 1,
        overflow: "auto",
      }}
      className="p-3"
    >
      <div>Long Content</div>
    </div>
  </div>
</div>
```