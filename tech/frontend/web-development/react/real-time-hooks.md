When needing real-time logic, do not use objects with methods to be called in `useEffect`, but use hooks that return values as they are changed. The real-time listener / connection should be closed automatically when the component is unmounted.

```tsx
function useRealtime<S extends z.ZodType<unknown>>(args: { 
      schema: S
      channel: string
    }
  ): {
    status: { 
      is: 'connecting'
    } | { 
      is: 'connected'
    } | { 
      is: 'closed'
      by: 'error'
    } | { 
      is: 'closed'
      by: 'server'
    },
    invalidMessageWasReceived: boolean;
    lastMessage: z.TypeOf<S>
    sendMessage: undefined | (() => void);
} {
  // ...
}

const { } = useRealtime({ channel: 'some-channel' })
```