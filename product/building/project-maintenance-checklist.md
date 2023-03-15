## When developing
- Will the contract (server, websockets, etc.) break between frontend and backend?
  - Use API versioning in URLs ('v1', 'v2' prefixes in the URLs)
    - Only increment the version on the endpoints that have breaking changes, and NOT an app wide version
- Will the changes break the contract between backend and the database (or any other internal services)
  - Write migrations

## Developing a feature from scratch, step-by-step

- Start with frontend
  - create routes and blank pages
    - when creating pages and routes, remember to centralize its URL and the query variations in a single module, so:
      - URL queries become type-safe, and breaking changes generate compile-time warnings 
      - that it becomes easier to move the page path around
      - example:
        ```typescript
        export const INDEX_ROUTE = {
          label: 'i18n translation key',
          path: '/',
          getHref: (query?: { page: number }) => {
            const queryString = new URLSearchParams(query || {}).toString()

            return queryString ? 
              `${INDEX_ROUTE.path}/?${queryString}`
              : INDEX_ROUTE.path
          },
        };
        ``` 
  - implement the UI
    - remember to implement responsive design
    - develop shared / ui-kit components
      - inspire yourself on 3rd-party component kits and ui-kits, so you can base yourself on abstractions that already work well, and not have to think about creating your own abstractions that may or not be flexible enough.
        - example: if you're using React-Bootstrap, wrap the React-Bootstrap components in your own components. Your own components should have the same names and accept the same props as the React-Bootstrap components they wrap.
      - create empty component files that just re-export the respective 3rd party ui-kit component, so you can have some middle-ground to apply customizations that the 3rd party ui-kit itself doesn't allow you to.
        - Example:
          - `src/components/ui-kit/components/modal/modal.tsx`
            ```tsx
            export {
              Modal,
              ModalHeader,
              ModalBody
            } from '3rd-party-ui-kit/modal'
            ```
        - you can use eslint rules to enforce the use of the re-exported components and stop direct imports to the 3rd party library
        - a quick and dirty start could be to import the whole 3rd party libraries (by importing its index) and re-exporting it again. The bundler will then tree-shake all the imported 3rd party components that are never used.
          - Example
            - `src/components/ui-kit/components/index.ts`
              ```tsx
              export * from '3rd-party-ui-kit'
              
              // Overridden components
              /*
                local exports take priority.
                https://stackoverflow.com/questions/41293108/how-to-do-re-export-with-overrides
                https://github.com/systemjs/systemjs/issues/1031#issuecomment-171262430
              */
              export {
                Modal,
                ModalHeader,
                ModalBody
              } from `./modal/modal.tsx`
              ```
          - You don't need to start developing new components right from the start. You can develop your project and importing the 3rd party ui kit directly, and when you really need to start applying conventions and configurations, you can just create a module import alias in the Typescript / Babel / Webpack config, or replace all imports with a codemod or using the IDE's _Find and Replace_.
    - only create new components or new props in a component when you need to use them.
    - components that are supposed to be nested in other components, or that are variations of the same component, should be implemented like this
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
  - develop the feature and page logic
    - implement forms
      - write down expected schemas in `logic/<feature>/<feature>.schemas.ts`. These will be moved to the shared library afterwards, so they can be used by both backend and frontend and keep a single validation logic across stacks.
    - create mock API methods in `logic/<feature>/<feature>.api.ts`
      - write down expected enums in `logic/<feature>/<feature>.enums.ts`
      - write down the expect types in a `logic/<feature>/<feature>.types.ts` file. These will be moved to the shared library afterwards, so they can be used by both backend and frontend and keep a strict typesafety across stacks.
    - all requests must implement the following logic
      - loading user feedback
      - refreshing user feedback
      - error handling and user feedback
        - logout if session became invalid or expired
        - unexpected response
        - 404 / does not exist
        - user is forbidden from accessing the content
        - connection error / no internet
      - update frontend caches
    - operations to implement
      > If you are listing, creating and editing resources in the same page, it's better to use a global state like Redux, to avoid callback hell and prop drilling between components and forms in order to keep the whole state updated.

      - listing
        - pagination
          - endless scroll
          - pagination bar
        - search for attributes
        - **?** storing request results in state to avoid re-doing requests **?** Use Redux
        - ability do delete resources
        - ability to select many resources and apply batch actions
      - open a single result
        - obtain resource from state, or request server for single resource
        - detect change in `id` parameter
          - refresh resource on `id` change
      
      > Try to define a model that you can reuse in all CRUD operations types and schemas. Extend the model types and schemas in each operation as you need.

      - create resource
        - form
          - connect DOM input elements to JS form instance
          - add error validations
            - write down validation schemas in `logic/<feature>/<feature>.schemas.ts`. These will be moved to the shared library afterwards, so they can be used by both backend and frontend and become coherent.
          - show form errors in DOM
          - implement form submission
      - update resource
        - **?** reuse `create resource` page **?**
        - obtain resource from state, or request server for single resource
        - detect change in `id` parameter
          - refresh resource on `id` change 
        - form
          - connect resource to JS form instance
          - connect DOM input elements to JS form instance
          - add error validations
            - write down validation schemas in `logic/<feature>/<feature>.schemas.ts`. These will be moved to the shared library afterwards, so they can be used by both backend and frontend and become coherent.
          - show form errors in DOM
          - implement form submission
    - add analytics events
- now do the backend
  - move what the frontend types and schemas that you created to the shared library, in order to be shared across backend and frontend
    - `@app/shared/src/<feature>/<feature>.dto.ts`
    - `@app/shared/src/<feature>/<feature>.enums.ts`
    - `@app/shared/src/<feature>/<feature>.schemas.ts`
  - create controllers for the methods that you need
  - write down the controllers logic and use mocks as persistence
  - now that you know what kind of data you will be storing
    - create your database entities
    - create / generate the needed database migrations
  - implement the database persistence in the controllers
    > **REMEMBER** to use database transactions / atomic reads and changes

    - listing
      - pagination
      - only query rows that the user is allowed to read
        - example: `{ where: { user: auth.user } }`
      - search for rows with attributes
      - caching
    - get single resource
      - caching
      - only query rows that the user is allowed to read
        - example: `{ where: { user: auth.user } }`
    - create
      - return `403 Forbidden` if user does not have permission to create the data
      - invalidate cache
      - send created resource
    - update
      - return `403 Forbidden` if user does not have permission to change the data
      - invalidate cache
      - send changed resource
    - add analytics events
