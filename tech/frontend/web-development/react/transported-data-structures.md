```tsx
export enum TransportFailure {
  ConnectionFailure = 'connection-failure',
  UnexpectedResponse = 'unexpected-response',
  AbortedAndDealtWith = 'aborted-and-dealt-with',
  Forbidden = 'forbidden',
  NotFound = 'not-found',
}

const TransportFailures: string[] = getEnumValues(TransportFailure)

export function isTransportFailure(t: string | undefined): t is TransportFailure {
  return TransportFailures.includes(t as string)
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