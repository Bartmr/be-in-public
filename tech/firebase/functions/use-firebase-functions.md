```tsx
import { FirebaseError } from "@firebase/util";
import { FunctionsErrorCode, httpsCallable } from "firebase/functions";
import { useMemo } from "react";
import { PageLogger } from "../../../logging/page-logger";
import { TransportFailure } from "../../../transports/transported-data/transport-failures";
import { throwError } from "../../../utils/throw-error";
import { getFirebaseCloudFunctions } from "./firebase-cloud-functions";

const FUNCTION_ERRORS_TO_TRANSPORT_FAILURES: {[K in FunctionsErrorCode]: TransportFailure} = {
  'functions/ok': TransportFailure.UnexpectedResponse,
  'functions/cancelled': TransportFailure.UnexpectedResponse,
  'functions/unknown': TransportFailure.UnexpectedResponse,
  'functions/invalid-argument': TransportFailure.UnexpectedResponse,
  'functions/deadline-exceeded': TransportFailure.UnexpectedResponse,
  'functions/not-found': TransportFailure.UnexpectedResponse,
  'functions/already-exists': TransportFailure.UnexpectedResponse,
  'functions/permission-denied': TransportFailure.UnexpectedResponse,
  'functions/resource-exhausted':  TransportFailure.UnexpectedResponse,
  'functions/failed-precondition': TransportFailure.UnexpectedResponse,
  'functions/aborted': TransportFailure.UnexpectedResponse,
  'functions/out-of-range':  TransportFailure.UnexpectedResponse,
  'functions/unimplemented': TransportFailure.UnexpectedResponse,
  'functions/internal': TransportFailure.UnexpectedResponse,
  'functions/unavailable':  TransportFailure.UnexpectedResponse,
  'functions/data-loss':  TransportFailure.UnexpectedResponse,
  'functions/unauthenticated': TransportFailure.UnexpectedResponse,
}

const FUNCTION_ERRORS = Object.keys(FUNCTION_ERRORS_TO_TRANSPORT_FAILURES)

type WrappedFirebaseFunction<Arguments, Response> = (args: Arguments) => Promise<{
  failure: TransportFailure
} | {
  failure?: undefined,
  data: Response
}>

export function useFirebaseFunction<Arguments, Response>(functionName: string): WrappedFirebaseFunction<Arguments, Response> {
  const fn = useMemo(() => {
    const _fn: WrappedFirebaseFunction<Arguments, Response> = async (args: Arguments) => {
      const firebaseFunction = httpsCallable<Arguments, Response>(getFirebaseCloudFunctions(), functionName)
  
      try {
        const res = await firebaseFunction(args)
        
        return {
          data: res.data
        }
      } catch (err) {
        if (err instanceof FirebaseError) {
  
          if(FUNCTION_ERRORS.includes(err.code)) {
            const errorCode = err.code as keyof typeof FUNCTION_ERRORS_TO_TRANSPORT_FAILURES
            const failure = FUNCTION_ERRORS_TO_TRANSPORT_FAILURES[errorCode] || throwError()

            if(failure === TransportFailure.UnexpectedResponse) {
              PageLogger.logError(`useFirebaseFunction:firebase-error:${errorCode}`, err)
            }

            return {
              failure
            }
          } else {
            PageLogger.logError('useFirebaseFunction:firebase-error', err)
            return {
              failure: TransportFailure.UnexpectedResponse
            }
          }
        } else {
          PageLogger.logError('useFirebaseFunction:unknown-error', err)
          return {
            failure: TransportFailure.UnexpectedResponse
          }
        }
      }
    }

    return _fn
  }, [functionName])

  return fn 
}
```