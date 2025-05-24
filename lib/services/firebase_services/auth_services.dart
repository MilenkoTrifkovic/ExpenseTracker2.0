import 'package:expense_tracker_2/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

/// Authentication service handling email/password and Facebook sign-in
///
/// ## Features
/// - Email/password registration
/// - Email/password login
/// - Facebook OAuth login
/// - Session management
class AuthServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Creates a new user account with email and password
  ///
  /// Throws [Exception] with error details if:
  /// - Email is invalid (FormatException)
  /// - Password is weak (FirebaseAuthException)
  /// - Email already in use (FirebaseAuthException)
  ///
  /// Example:
  /// ```dart
  /// final user = await AuthServices.signUp('test@example.com', 'Password123');
  /// ```
  static Future<AppUser> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return AppUser(
        email: userCredential.user!.email!,
        uid: userCredential.user!.uid,
      );
    } catch (e) {
      throw Exception('Error during sign up: $e');
    }
  }

  /// Authenticates an existing user with email and password
  ///
  /// Throws [Exception] when:
  /// - User not found (FirebaseAuthException)
  /// - Wrong password (FirebaseAuthException)
  /// - Network errors (FirebaseAuthException)
  ///
  /// Example:
  /// ```dart
  /// final user = await AuthServices.signIn('existing@example.com', 'Password123');
  /// ```
  static Future<AppUser> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return AppUser(
        email: userCredential.user!.email!,
        uid: userCredential.user!.uid,
      );
    } catch (e) {
      throw Exception('Error during sign in: $e');
    }
  }

  /// Terminates the current user session
  ///
  /// Throws [Exception] if:
  /// - No active session exists
  /// - Network errors occur
  static Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Error during sign out: $e');
    }
  }

  /// Authenticates using Facebook OAuth
  ///
  /// Requires:
  /// - Facebook app configuration in Firebase
  /// - Internet permissions in Android/iOS manifests
  ///
  /// Throws [Exception] when:
  /// - User cancels login (LoginResult.status != success)
  /// - Facebook token invalid
  /// - Firebase linking fails
  ///
  /// Example:
  /// ```dart
  /// final user = await AuthServices.signInWithFacebook();
  /// ```
  static Future<AppUser> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: [
          'public_profile',
          'email',
        ],
      );

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        return AppUser(
          email: userCredential.user!.email!,
          uid: userCredential.user!.uid,
        );
      } else {
        throw Exception('Facebook login failed: ${loginResult.message}');
      }
    } catch (e) {
      throw Exception('Error during Facebook sign in: $e');
    }
  }
}
