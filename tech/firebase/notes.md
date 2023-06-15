- https://www.fullstackfirebase.com/
- Monitor and Limit usage
  - https://firebase.google.com/docs/firestore/monitor-usage
- Avoid abusive traffic
  - https://firebase.google.com/support/guides/security-checklist#avoid_abusive_traffic
  - Cloud Functions
    - https://cloud.google.com/functions/docs/configuring/max-instances
- Security checklist
  - https://firebase.google.com/support/guides/security-checklist
- Launch checklist
  - https://firebase.google.com/support/guides/launch-checklist
## Anonymous user upgrade doesn't work

https://github.com/firebase/firebaseui-web/issues/1002

This error happens when you don't use the auth from the compatibility layer.

Make sure that instead of doing:

```
import { getAuth } from "firebase/auth";
const auth = getAuth(app);
```

You're using the compatibility layer instead:

```
import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';
const auth = firebase.auth(app);
```