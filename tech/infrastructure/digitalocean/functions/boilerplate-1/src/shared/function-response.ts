export type FunctionResponse<Body = undefined, Headers extends Record<string, string> | undefined = undefined> = Promise<{
  headers?: Headers,
  body?: Body,
  statusCode?: number
}>