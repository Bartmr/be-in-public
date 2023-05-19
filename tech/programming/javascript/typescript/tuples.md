```ts
type AllButLast<T extends unknown[]> = T extends [...infer FirstOnes, unknown] ? FirstOnes : unknown[];
type Last<T extends unknown[]> = T extends [...unknown[], infer L] ? L : never;

type Functions = [
  (() => number),
  (() => string)
]

type ReturnTypesOfFunctions = [
    ...{
      [K in keyof Functions]: ReturnType<Functions[K]>
    }
  ]
```