## Delete source maps

```bash
find .next/static -name "*.map" -type f -delete
```

## Validation && Authentication

```typescript
export default withAuthentication(
  (authContext) => withValidation(
    {
      params: z.object({}),
      query: z.object({}),
      body: z.object({}),
    },
    ({ params, query, body }) => {
      // Implementation
    }
  )
)
```
```typescript
type AuthContext = { user: User }
type WithAuthentication = () => ((args: AuthContext) => void)
type WithOptionalAuthentication = () => ((args?: AuthContext) => void)
```

## Deploying as a conventional server

- Deploy the client side as static files by using `next export`
- Deploy the API side in  a regular server by building the project and starting it
  - CORS setup might be needed
- To stop the CIs from activating and building changes that we're only made to the backend or only made for the frontend, each CI should only monitor a specific branch for them, like `build:api` or `build:client` and NOT `main`