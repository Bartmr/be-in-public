## Atomic Transactions between Microservices

- For each action in a microservice, have 3 endpoints:
  - `/action/prepare`: opens a transaction and locks the data, then runs all the persistence tasks like finds and saves, and returns data. Also returns a `transactionId` in its response
  - `/action/commit`: the requesting microservice calls this endpoint, sending the matching `transactionId`, to seal the changes and commit the given transaction
  - `/action/rollback`: the requesting microservice calls this endpoint, sending the matching `transactionId`, to rollback all the changes from `/action/prepare` and close the given transaction
- If neither `/action/commit` or `/action/rollback` are called by the requesting microservice, a timeout should automatically call for a rollback and close the transaction.
