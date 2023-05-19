## Delete source maps

```bash
find .next/static -name "*.map" -type f -delete
```

## Validation && Authentication

```typescript
export default  function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  withAuthentication(
    req,
    res,
    (authContext) => {
      withValidation(
        req,
        res
        {
          params: z.object({}),
          query: z.object({}),
          body: z.object({}),
        },
        ({ params, query, body }) => {
          res.status(200).json({ name: 'John Doe' })
        }
      )
    }
  )
}


```
```typescript
type AuthContext = { user: User }
type WithAuthentication = () => ((args: AuthContext) => void)
type WithOptionalAuthentication = () => ((args?: AuthContext) => void)
```