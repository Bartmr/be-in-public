## Method 1: simple way of sharing code without pre-building or multiple `npm install` runs

For simple CIs (like Netlify) that abstract a lot of the building process, it's recommended to have a single `npm install` run and only use a single `node_modules` directory that will be later cached by the service.

During development, you also need a way to be able to edit shared code without having to rebuild it in order to use the changes, to take advantage of hot reload everywhere, no matter if it's code from the app or shared code. This sometimes is not possible with monorepo tools like `lerna`

Given the following project structure...

- shared
  - module.ts
- api
  - main.ts
- web-app
  - index.ts

you need to be able to import `module.ts`.

If you use path aliases from Webpack or Typescript, you would need to need another `node_modules` directory, since node searches for `node_modules` in the current directory first, and then traverses the parent directories till it reaches the root of your hard drive.

**The solution** is to `symlink` the `shared` directory to `web-app/shared` and `api/shared` when setting up the project for the first time. If you can't symlink modules during CI builds or can't access the top directories, you can just copy `shared` into the services that need to import it.

So the new structure would be:

- shared
  - module.ts
- api
  - shared (symlinked to `shared`)
  - main.ts
- web-app
  - shared (symlinked to `shared`)
  - index.ts
