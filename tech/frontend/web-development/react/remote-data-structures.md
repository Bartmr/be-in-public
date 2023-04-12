```tsx
export enum RemoteDataFailure {
  ConnectionFailure = 'connection-failure',
  UnexpectedResponse = 'unexpected-response',
  AbortedAndDealtWith = 'aborted-and-dealt-with',
  Forbidden = 'forbidden',
  NotFound = 'not-found',
}

const RemoteDataFailures: string[] = getEnumValues(RemoteDataFailure)

export function isRemoteDataFailure(t: string | undefined): t is RemoteDataFailure {
  return RemoteDataFailures.includes(t as string)
}

type State = {
  /*
    will be compared in useEffect,
    to see if the app is already loading the needed resource,
    or to start loading a new one

    example:

    useEffect(() => {
      if(resourceState.loading.id === router.query.id) {
        return;
      }

      // ...fetch new resource
    }, [])
  */
  loading?: { id: string };
  error?: TransportFailure | 'other-error-string-literal';
  //
  data?: Data | "no-previous-data";
  //
  submittingRating?: boolean;
  ratingSubmissionError?: TransportFailure | 'other-error-string-literal'
}
```