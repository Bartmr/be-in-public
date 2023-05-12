## Structure

- components
  - protons
    - router-link.tsx
    - external-link.tsx
  - routing
    - {page,screen}
      - {page,screen}.tsx
      
      or
        
      - variation-1
        - page-variation-1.tsx
      - page
        - page.tsx

      or

      - page.tsx
      - layouts
        - variation-n
          - variation-n-layout.tsx
    - authentication-gate
      - authentication-gate.tsx
  - shared
  - ui-kit
    - core
      - colors
      - contrasting-colors
      - fonts
      - spacers
      - sizes
    - components
    - global-styles (in case CSS is used)
- logic
  - internals
    - apis
      - firebase
      - main
        - use-main-api-socket.tsx
        - use-main-api.tsx
    - logging
      - logger.tsx
    - navigation
    - runtime
      - environment-variables.tsx
    - storage
      - local-storage.ts
    - transports
      - transport-failures.ts
    - utils
    - i18n
      - get-text.ts
        - get translated text
  - analytics
  - auth
    - auth-state.ts
    - auth-effects.ts
    - auth-actions.ts
  - feature-n
    - feature-n.api.ts
    - feature-n.schemas.ts
    - feature-n.types.ts
- {templates,screens}
  > contains the app's pages / screens

  - {template,screen}-n
    - context
      > for complex logic
      - {template,screen}-n-state.ts
      - {template,screen}-n-actions.ts
      - {template,screen}-n-effects.ts
    - {template,screen}-n-template.tsx
    - {template,screen}-n-routes.tsx
    - {templates,screens}
      - single-{template,screen}-n-template.tsx
      - single-{template,screen}-n-routes.tsx

## Declaring a new page or screen

```tsx
export function SomeTemplate() {
  return <Page>
    <Layout>
      <AuthenticationGate rules={authRules}>
      {content}
      </AuthenticationGate>
    </Layout>
  </Page>
}
```

## Complex logic structure

When a feature becomes too complex in the application, split it into the following sections:

- `state`
  - stores the data to be showed on the screen and be processed and changed by `actions` and `effects`
- `actions`
  - contains all the methods available for a given feature. These methods needs to be called explicitly to start an action.
- `effects`
  - contains all the logic that reacts to state changes

## Explanation

### `components`

- this is where you should store your components

### `components/protons`

- Elements that override native browser elements. Name is given after atomic design

### `components/protons/router-link`

- overrides `<a>` in order to behave as a single page application with NextJS

### `components/routing`

- Components related to the application routing and page layout

### `components/routing/page/page`

- declares a new page in the app
- loads SEO tags that are specific to the page you are viewing
- serves as gate till authentication is loaded

### `components/routing/page/layout`

- contains many of the app's page layouts, like sidebar-menu

### `components/routing/app`

- contains components that are bound to the app's root component, like location change listeners and device gates

### `components/routing/redirect`

- simple component that triggers a page redirect

### `components/shared`

- any type of component that is used in many pages

### `components/ui-kit`

- everything related to the overall design and ui-kit of the application

### `components/ui-kit/components`

- components that are not attached to a specific feature of the application
- they have no logic and are just visual
- they are just part of the app's UI-kit

### `components/ui-kit/core`

- hooks that manage and return design tokens and values for styling
- contain logic to control the overall appearance of the app

### `components/ui-kit/contrasting-colors`

- Get a contrasting text color based on the background color you are using. Useful for dynamic color changes, where a dark primary color with light text needs to be changed for a light primary color with dark text.

### `components/ui-kit/extra-token`

- contains more design tokens not included in the default Ant Design tokens

### `logic`

- contains your non-visual logic
- split by features or backend entities. The directory structure should closely ressemble the features or entities structure in the backend
- contains types, validation schemas, hooks and api requests

### `logic/auth`

- contains authentication and authorization logic

### `logic/auth/auth-state`

- stores the current user's data and tokens

### `logic/auth/auth-effects`

- Listens to Firebase's auth state, and reacts to logins and logouts

### `logic/internals`

- has all logic that is not directly tied to the value or purpose of your project
- has logic that is universal to any other client-side app

### `logic/internals/apis`

- contains abstractions over the protocols you use to communicate with your backend services
- contains the logic that coordinates backend communication with your app's state, like authentication and error handling

### `logic/internals/i18n`

- contains everything related to internationalization

### `logic/internals/i18n/get-text`

- hook that returns the app's text that the user sees. In the future, the text should change according to the user's location

### `logic/internals/runtime`

- has all the logic related to runtime and environment

### `logic/internals/runtime/environment-variables`

- this is where you get your environment variables from

### `logic/internals/runtime/storage`

- contains logic for persisting data locally

### `logic/internals/transports`

- contains constants and utilities for dealing with the many states of data transported from outside sources.

### `logic/internals/transports/transport-failures`

- enum of all the predicted errors that can happen when loading data from outside sources

### `logic/internals/utils/use-queue`

- an easy way to run actions sequentially in a more procedural way, and not as React effects

### `logic/internals/utils/use-state-and-ref`

- when in the middle of an asynchrounous method, sometimes you might need to access the most recent data being displayed in a React component. By using a React `ref` connected to a state, you get both a React compliant state, and a object reference with the latest state present in the component.

### `templates`

- contains your applications pages and screens
- pages are places where you mix and call features from [`logic`](#logic)

### `pages`

- Bridge between NextJS and your pages
- Each NextJS page must render a page in `template`

### `pages/_app`

- Entry point for the application.
- Global states like authentication are initialized here

### `pages/_document`

- HTML template that is rendered during NextJS build. This is where you put your 3rd party script tags
- contains SEO tags specific to the whole app
