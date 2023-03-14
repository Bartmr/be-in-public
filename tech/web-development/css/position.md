## Absolute / Sticky

### For absolute / sticky positioning to start from the parent element, one must do
```scss
.parent {
  position: relative;
}

.child {
  position: absolute; // or sticky
  top: 0; // 0 pixels from .parent top
}
```