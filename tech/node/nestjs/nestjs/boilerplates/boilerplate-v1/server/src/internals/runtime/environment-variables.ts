import { z } from 'zod';

const EnvironmentVariablesSchema = z.object({
  DB_HOST: z.string(),
  DB_PORT: z.number({ coerce: true }),
  DB_NAME: z.string(),
  DB_USER: z.string(),
  DB_PASSWORD: z.string(),
  LOG_DEBUG: z
    .boolean()
    .optional()
    .transform((v) => {
      if (
        process.env.NODE_ENV === 'development' ||
        process.env.NODE_ENV === 'test'
      ) {
        return true;
      } else {
        return v;
      }
    }),
  WEB_APP_ORIGIN: z.string(),
});

export const EnvironmentVariables = EnvironmentVariablesSchema.parse({
  ...process.env,
});
