- `nest new project-name`
- Remove generated `.git` repository if needed
- Add to `tsconfig.json`
  ```
  "strict": true,
  "noUncheckedIndexedAccess": true,
  ```
- Add `"**/spec"` to `exclude` in `tsconfig.build.json` in order to not bundle test files in the production build
- Enable [shutdown hooks](https://docs.nestjs.com/fundamentals/lifecycle-events#application-shutdown) for graceful shutdown
  - In case you use Prisma
    - <https://docs.nestjs.com/recipes/prisma#issues-with-enableshutdownhooks>
- switch E2E tests directory to `src`, to have the test files alongside the code they test
- Replace the `format` command in `package.json` with `prettier --write .` in order to prettify all supported files
- Add `typecheck` command in `package.json` with `tsc --noEmit`
