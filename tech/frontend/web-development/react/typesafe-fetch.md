```tsx
import { useMemo } from "react";
import { z } from "zod";
import { Logger } from "../../logging/logger";
import { EnvironmentVariables } from "../../runtime/environment-variables";
import { TransportFailure } from "../../transports/transported-data/transport-failures";

interface MainApi {
  fetch<ZodSchema extends z.ZodType<{ status: number; body?: unknown }>>(args: {
    schema: ZodSchema;
    path: string;
    body?: unknown;
    method: "HEAD" | "GET" | "DELETE" | "POST" | "PATCH" | "PUT";
  }): Promise<
    | {
        failure: TransportFailure;
      }
    | {
        failure?: undefined;
        response: z.TypeOf<ZodSchema>;
      }
  >;
}

export function useMainApi(): MainApi {
  return useMemo(() => {
    return {
      fetch: async (args) => {
        let response: Response;

        try {
          response = await fetch(
            `${EnvironmentVariables.MAIN_API_URL}${args.path}`,
            {
              method: args.method,
              body: ["POST", "PATCH", "PUT"].includes(args.method)
                ? JSON.stringify(args.body)
                : undefined,
              headers: {
                "Content-Type": "application/json",
              },
            }
          );
        } catch (error) {
          return {
            failure: TransportFailure.ConnectionFailure,
          };
        }

        const responseText = await response.text();

        const responseJSON = responseText
          ? JSON.parse(responseText)
          : undefined;

        const validationResult = args.schema.safeParse({
          status: response.status,
          body: responseJSON,
        });

        if (validationResult.success) {
          return {
            response: validationResult.data,
          };
        } else {
          /*
            Differenciate between a resource not existing or sending a request to an incorrect URL
          */
          if (response.status === 404 && response.headers.get('X-Resource-Not-Found') === 'true') {
            return {
              failure: TransportFailure.NotFound,
            };
          } else if (response.status === 401) {
            await logout()

            return {
              failure: TransportFailure.AbortedAndDealtWith
            }
          } else if (response.status === 403) {
            return {
              failure: TransportFailure.Forbidden,
            };
          } else {
            Logger.logError(
              "use-main-api:fetch:unexpected-response",
              new Error(),
              {
                request: {
                  path: args.path,
                  method: args.method,
                  body: args.body,
                },
                response: {
                  status: response.status,
                  validationErrors: validationResult.error.format(),
                },
              }
            );

            return {
              failure: TransportFailure.UnexpectedResponse,
            };
          }
        }
      },
    };
  }, []);
}
```