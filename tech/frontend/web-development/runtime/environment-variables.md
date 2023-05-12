```tsx
import { z } from "zod";

const APP_ENV = process.env.NEXT_PUBLIC_APP_ENV;

const schema = z
  .object({
    APP_ENV: z.union([
      z.literal("local"),
      z.literal("staging"),
      z.literal("production"),
    ]),
    PATH_PREFIX: z
      .string()
      .optional()
      .transform((pathPrefix) => pathPrefix || ""),
    DISABLE_LOGGING_LIMIT: z
      .boolean()
      .optional()
      .transform((v) => {
        if (APP_ENV === "local") {
          return true;
        } else {
          return v;
        }
      }),
    LOG_DEBUG: z
      .boolean()
      .optional()
      .transform((v) => {
        if (APP_ENV === "local") {
          return true;
        } else {
          return v;
        }
      }),
    MAIN_API_URL: z.string(),
    DEBUG_FEATURES: z
      .boolean({ coerce: true })
      .optional()
      .transform((v) => {
        if (APP_ENV === "local") {
          return true;
        } else {
          return v;
        }
      }),
    DISABLE_ERROR_BOUNDARIES: z
      .string()
      .optional()
      .transform((v) => {
        if (v === "true") {
          return true;
        } else if (v === "false") {
          return false;
        } else {
          if (APP_ENV === "local") {
            return true;
          } else {
            return false;
          }
        }
      }),

    FIREBASE_API_KEY: z.string(),
    FIREBASE_AUTH_DOMAIN: z.string(),
    FIREBASE_PROJECT_ID: z.string(),
    FIREBASE_STORAGE_BUCKET: z.string(),
    FIREBASE_MESSAGING_SENDER_ID: z.string(),
    FIREBASE_APP_ID: z.string(),
  })
  .required();

const environmentVariablesValidationResult = schema.parse({
  APP_ENV: process.env.NEXT_PUBLIC_APP_ENV,
  MAIN_API_URL: process.env.NEXT_PUBLIC_MAIN_API_URL,
  DEBUG_FEATURES: process.env.NEXT_PUBLIC_DEBUG_FEATURES,
  DISABLE_ERROR_BOUNDARIES: process.env.NEXT_PUBLIC_DISABLE_ERROR_BOUNDARIES,

  FIREBASE_API_KEY: process.env.NEXT_PUBLIC_FIREBASE_API_KEY,
  FIREBASE_AUTH_DOMAIN: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN,
  FIREBASE_PROJECT_ID: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID,
  FIREBASE_STORAGE_BUCKET: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET,
  FIREBASE_MESSAGING_SENDER_ID:
    process.env.NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID,
  FIREBASE_APP_ID: process.env.NEXT_PUBLIC_FIREBASE_APP_ID,
});

export const EnvironmentVariables = environmentVariablesValidationResult;

```