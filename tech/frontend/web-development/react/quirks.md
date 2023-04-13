## `useEffect` runs twice

- `React.StrictMode` runs `useEffect` twice during development. This is actually a feature to enforce the programmer to ignore needless re-runs of `useEffect`, and to avoid starting multiple flows of data fetching when reacting to a dependency change.
