```typescript
import { z } from "zod";
import axios from 'axios'

export const HttpService = {
  fetch: async <Schema extends z.ZodType<{
    status: number;
    body?: unknown;
  }>>(
    schema: Schema,
    {
      method,
      url,
      body,
      headers,
    }: {
      url: string;
      headers?: { [key: string]: string };
      method: 'GET' | 'DELETE' | 'HEAD' | 'POST' | 'PUT' | 'PATCH';
      body?: unknown
    },
  ): Promise<z.TypeOf<Schema>>  => {


    const response = await axios({
      method: method.toLowerCase(),
      url,
      headers: {
        'Accept': 'application/json'
      },
      data: body,
      validateStatus: () => true,
    });

    const responseValidation = schema.safeParse({
      status: response.status,
      body: response.data as unknown,
    });

    if (!responseValidation.success) {
      throw new Error(JSON.stringify({
        url,
        method,
        requestBody: body,
        status: response.status,
        responseBody: response.data as unknown,
        errorMessagesTree: responseValidation.error,
      }, undefined, 2));
    } else {
      return responseValidation.data;
    }
  }
}
```
