import './load-env-vars'
import { FirebaseAdmin } from '../logic/app-internals/apis/firebase/admin/firebase-admin';
import { throwError } from '../logic/app-internals/utils/throw-error';

type MigrationFromFirestore = {
  index: number;
  name: string;
}

const firestore = FirebaseAdmin.firestore()

const MigrationsCollection = firestore
  .collection('migrations')
  .withConverter({
    toFirestore: (data: MigrationFromFirestore) => data,
    fromFirestore: (snap: FirebaseFirestore.QueryDocumentSnapshot) =>
      snap.data() as MigrationFromFirestore
  })

const migrations:Array<{ name: string, run: (args: {
  firestoreTransaction: FirebaseFirestore.Transaction
}) => Promise<void>}> = [];

async function runMigrations() {
  await firestore.runTransaction(async (transaction) => {

    const executedMigrations = await transaction.get<{
      name: string
    }>(
      MigrationsCollection
    )


    const executedMigrationsNames = executedMigrations.docs.map((d) => d.data().name)

    for(let i = 0; i < migrations.length; i++) {
      const migration = migrations[i] || throwError();

      if(executedMigrationsNames.includes(migration.name)) {
        continue
      }

      console.info(`Running migration "${migration.name}"...`)

      await migration.run({
        firestoreTransaction: transaction
      })

      transaction.set(
        MigrationsCollection.doc(migration.name),
        {
          index: i,
          name: migration.name,
        }
      )
    }
  })
}

runMigrations().catch((err) => {
  console.error(err);
  process.exit(1);
});
