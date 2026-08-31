import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';

class AuthService {
// Private instance of FirebaseAuth (Encapsulation)
final FirebaseAuth _auth = FirebaseAuth.instance;

// Helper method: Map Firebase User to AppUser
AppUser? _userFromFirebase(User? user) {
return user != null ? AppUser(uid: user.uid, email: user.email) : null;
}

// Stream: Emits AppUser on login/logout state changes
Stream<AppUser?> get authStateChanges {
return _auth.authStateChanges().map(_userFromFirebase);
}

// Sign in with Email & Password
Future<AppUser?> signInWithEmail(String email, String password) async {
try {
final UserCredential credential = await _auth.signInWithEmailAndPassword(
email: email.trim(),
password: password.trim(),
);
return _userFromFirebase(credential.user);
} on FirebaseAuthException catch (e) {
throw 'An unexpected error occurred. Please try again.';
}


// Sign Out
Future<void> signOut() async {
await _auth.signOut();

