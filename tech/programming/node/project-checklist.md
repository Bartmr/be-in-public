- Set up Typescript
  - https://github.com/tsconfig/bases
  - Add to `tsconfig.json`
    ```
    "outDir": "dist",
    "sourceMap": true,
    "noUncheckedIndexedAccess": true
    ```
    ```
    "ts-node": {
      "transpileOnly": true
    }
    ```
- Setup ts-node and nodemon
- Setup production build and start commands
  - ```
    "start": "node --enable-source-maps dist/index.js"
    ```
- Setup linter
- Setup prettier
- Setup pre-commit hooks