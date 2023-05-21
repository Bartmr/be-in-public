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

## Realtime and sockets

From <https://vercel.com/guides/publish-and-subscribe-to-realtime-data-on-vercel>

- [Ably](https://ably.com/)
- [Convex](http://convex.dev/)
- [Pusher](https://vercel.com/guides/deploying-pusher-channels-with-vercel)
- [PubNub](https://www.pubnub.com/)
- [Firebase Realtime Database](https://firebase.google.com/docs/database)
- [TalkJS](https://talkjs.com/)
- [SendBird](https://sendbird.com/)
- [Supabase](https://supabase.com/realtime)