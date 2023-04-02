## Where value starts with

```tsx
const searchTerm = getSearchableString(args.searchTerm)
  
const strlength = searchTerm.length;
const strFrontCode = searchTerm.slice(0, strlength-1);
const strEndCode = searchTerm.slice(strlength-1, searchTerm.length);
// This is an important bit..
const endCode = strFrontCode + String.fromCharCode(strEndCode.charCodeAt(0) + 1);

ProfilesCollection.where(
    getTypesafeObjectFieldPath<Profile>().and("searchableFirstName").end(),
    '>=', searchTerm
    )
  .where(
    getTypesafeObjectFieldPath<Profile>().and("searchableFirstName").end(),
    '<',  endCode
  ).get()
```

## Restrict all client-side access

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```