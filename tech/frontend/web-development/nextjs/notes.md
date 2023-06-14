## Delete source maps

```bash
find .next/static -name "*.map" -type f -delete
```

## Validation && Authentication

```typescript
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  withAuthentication(
    { req, res, options: {} }
    (authContext) => {
      withValidation(
        { req, res, options: {} }
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

## Deploying as a conventional server

- Deploy the client side as static files by using `next export`
- Deploy the API side in  a regular server by building the project and starting it
  - CORS setup might be needed
- To stop the CIs from activating and building changes that we're only made to the backend or only made for the frontend, each CI should only monitor a specific branch for them, like `build:api` or `build:client` and NOT `main`
