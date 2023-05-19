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