import { initializeApp } from 'firebase-admin';

export class FirebaseService {
  constructor(private firebaseApp: ReturnType<typeof initializeApp>) {}

  getAuth() {
    return this.firebaseApp.auth();
  }
}
