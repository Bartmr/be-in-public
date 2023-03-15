import { Module } from '@nestjs/common';
import * as firebaseAdmin from 'firebase-admin';
import { applicationDefault } from 'firebase-admin/app';
import { FirebaseService } from './firebase.service';

type FirebaseApp = ReturnType<(typeof firebaseAdmin)['initializeApp']>;

@Module({
  providers: [
    {
      provide: FirebaseService,
      useFactory: () => {
        let app: FirebaseApp;

        if (process.env.NODE_ENV === 'development') {
          app = firebaseAdmin.initializeApp({
            projectId: 'project-dev',
          });
        } else {
          app = firebaseAdmin.initializeApp({
            credential: applicationDefault(),
          });
        }

        return new FirebaseService(app);
      },
    },
  ],
  exports: [FirebaseService],
})
export class FirebaseModule {}
