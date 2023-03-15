## Resolving anonymous user merge conflicts

```typescript
// https://firebase.google.com/docs/auth/web/firebaseui#upgrading_anonymous_users
firebaseAuthUI.start("#firebase-ui", {
  signInOptions: [
    {
      provider: firebase.auth.EmailAuthProvider.PROVIDER_ID,
      requireDisplayName: false,
    },
  ],
  callbacks: {
    signInSuccessWithAuthResult: () => false,
    signInFailure: async (error) => {
      // For merge conflicts, the error.code will be
      // 'firebaseui/anonymous-upgrade-merge-conflict'.
      if (error.code != "firebaseui/anonymous-upgrade-merge-conflict") {
        return Promise.resolve();
      }
      // The credential the user tried to sign in with.
      var cred = error.credential;
      // Copy data from anonymous user to permanent user and delete anonymous
      // user.
      // ...
      // Finish sign-in after data is copied.
      await signInWithCredential(getFirebaseAuth(), cred);
    },
  },
  autoUpgradeAnonymousUsers: true,
});
```