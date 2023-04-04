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
      > for colors, contrasting-colors, typography
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
      - remote-data-failures.ts
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
    - {templates,screens}
      - single-{template,screen}-n-template.tsx