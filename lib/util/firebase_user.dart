import 'package:firebase_auth/firebase_auth.dart';

User getFirebaseUser() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  return _auth.currentUser;
}
