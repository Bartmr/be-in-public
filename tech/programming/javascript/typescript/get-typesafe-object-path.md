```ts
export type TypesafeObjectFieldPathPointer<T> = {
  and<K extends keyof T>(keyOrIndex: K): TypesafeObjectFieldPathPointer<T[K]>;
  end(): string;
};

function getDeeperTypesafeObjectFieldPath<T>(previousRecursionPath: string) {
  return <K extends keyof T>(
    keyOrIndex: K
  ): TypesafeObjectFieldPathPointer<T[K]> => {
    if (typeof keyOrIndex === "number" || typeof keyOrIndex === "string") {
      const newPath = `${previousRecursionPath}${
        previousRecursionPath ? "." : ""
      }${keyOrIndex}`;

      return {
        and: getDeeperTypesafeObjectFieldPath<T[K]>(newPath),
        end: () => newPath,
      };
    } else {
      throw new Error();
    }
  };
}

/*
    README:
    getTypesafeObjectFieldPath(values).and("houses").and(index).and("loanInterestPurchase").end()
    will return a lodash-like object path "houses.0.loanInterestPurchase"
    suitable for field names in most form libraries and also ensuring type safety
    if any of the key names in the object tree changes.
    Be sure to call .end() when you're done composing the path and want the path string returned.
*/
export function getTypesafeObjectFieldPath<T>(
  _values?: T
): Pick<TypesafeObjectFieldPathPointer<T>, "and"> {
  return {
    and: getDeeperTypesafeObjectFieldPath<T>(""),
  };
}
```