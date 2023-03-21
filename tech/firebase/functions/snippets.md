## Defining a collection

```ts
import { Profile } from "./profile.types";

export const ProfilesCollection = FirebaseAdmin.firestore()
  .collection('profiles')
  .withConverter<Profile>({
    fromFirestore: (d) => d.data() as Profile,
    toFirestore: (d) => d
  })
```

## Validate request data

```ts
import * as z from 'zod'
import * as functions from "firebase-functions";

export function validateRequestDataWithZod<Z extends z.ZodType<unknown>>(
  schema: Z,
  data: unknown,
): z.TypeOf<Z> {
  const validationResult = schema.safeParse(data);

  if (!validationResult.success) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      JSON.stringify(validationResult.error.format(), undefined, 2)
    );
  }

  return validationResult.data;
}
```

## Firebase Admin singleton

```ts
import * as admin from "firebase-admin";
import * as functions from 'firebase-functions'

export const FunctionsFirebaseAdmin = admin.initializeApp(
  functions.config().firebase
);
```

## Exporting index.ts

```ts
import './load-env-vars'

export * from './auth/auth.functions'
export * from './feature-1/feature-1.functions'
export * from './feature-2/feature-2.functions'
export * from './feature-3/feature-3.functions'
```