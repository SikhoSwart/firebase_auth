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
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Register with Email & Password
  Future<AppUser?> registerWithEmail(String email, String password) async {
    try {
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return _userFromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Map Firebase exception codes into user-friendly UI strings
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-credential':
        return 'Invalid login credentials.';
      default:
        return e.message ?? 'Authentication error occurred.';
    }
  }
}