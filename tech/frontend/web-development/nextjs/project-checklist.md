- Enable `noUncheckedIndexedAccess` in `tsconfig.json`
- If you're using Tailwind
  - Make sure all files containing JSX are scanned by Tailwind by adding the following to `tailwind.config.js`
    ```
    content: [
      './src/**/*.{jsx,tsx,mdx}',
    ],
    ```
  - see `tech/frontend/web-development/tailwind/notes.md` in case you're planning on using tailwind as utilities with another CSS Framework
- Validate both client and API environment variables during build-time
  - Write the environment variable modules in pure javascript, and with Typescript declaration files on the side, so that these environment variable modules can be `require()` in `next.config.js` and run their validation logic
    - see `tech/frontend/web-development/runtime/environment-variables.md`
    - Example
      - `logic/internals/runtime/api-environment-variables.js`
      - `logic/internals/runtime/api-environment-variables.d.ts`
      - `logic/internals/runtime/client-environment-variables.js`
      - `logic/internals/runtime/client-environment-variables.d.ts`
- Install `prettier`
- Set vscode `settings.json` to
  - autosort and remove unused imports when saving a file
  - automatically prettify when saving a file
  -
    ```json
    {
      "editor.formatOnSave": true,
      "editor.codeActionsOnSave": {
				"source.organizeImports": true
			},
    }
    ```
- Move typechecking and linting from the build process to a separate npm command
  - If using Supabase, don't forget to call `supabase db lint --level error` to lint your Postgres code
  - Validate Prisma schema file by calling `prisma validate`
  - call that npm command during precommit
- In Supabase config, set
  ```
  [auth.email]
  double_confirm_changes = false
  enable_confirmations = true
  ```