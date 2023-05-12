## Faster hot reload with non-JS files

Instead of importing all of the `scss` files in a single `scss` itself (generally `index.scss`), import all your styles in Javascript files. When importing everything in a single `scss` file, the build system will compile all the `scss` files, even if just one was changed. When you import multiple `scss` files in a Javascript file, the build system recognizes each `scss` file as an independent module, and will only compile the `scss` file that changed

**WRONG**:

index.scss
```scss
@import "variables";
@import "buttons";
@import "forms";
@import "utilities";
```

**RIGHT**:

buttons.scss | forms.scss | utilities.scss
```scss
@import "variables";

.component {
  color: #000000;
}
```

global-styles.js
```js
import "./buttons.scss";
import "./forms.scss";
import "./utilities.scss";
```