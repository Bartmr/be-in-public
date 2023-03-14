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
  isLoading?: boolean;
  error?: TransportFailure | 'other-error-string-literal';
  //
  data?: Data | "no-previous-data";
  //
  isSubmittingRating?: boolean;
  ratingSubmissionError?: TransportFailure | 'other-error-string-literal'
}
```