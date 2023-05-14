## Use Tailwind as utilities with another CSS Framework

tailwind.config.js
```js
module.exports = {
  important: true,
  corePlugins: {
    preflight: false,
  }
}
```

index.css
```css
@tailwind utilities;
```