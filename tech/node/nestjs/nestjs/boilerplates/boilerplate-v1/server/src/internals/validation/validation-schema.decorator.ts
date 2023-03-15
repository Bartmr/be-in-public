/* eslint-disable @typescript-eslint/explicit-function-return-type */
/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
import { SetMetadata } from '@nestjs/common';
import { z } from 'zod';

export const VALIDATION_SCHEMA_KEY = 'zod-validation-schema';

export type SupportedValidationSchema = z.ZodType<object>;

/**
 * Schema must be an array or an object marked with .required().
 *
 * NestJS parsers always parse everything out of the request as an object literal.
 * Even when the query parameters or bodies are undefined.
 */
export const ValidationSchema = (schema: SupportedValidationSchema) =>
  SetMetadata(VALIDATION_SCHEMA_KEY, schema);
