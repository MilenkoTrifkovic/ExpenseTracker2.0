import 'package:expense_tracker_2/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<AppUser?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return AppUser(
        email: userCredential.user!.email!,
        uid: userCredential.user!.uid,
      );
    } catch (e) {
      return null;
    }
  }

  static void signIn(String email, String password) async {
    // static Future<AppUser?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
    }
  }

  static Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      //we can throw or handle the error further if needed.
    }
  }

  static Future<AppUser?> signInWithFacebook() async {
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
      print("Error during Facebook login: $e");
      return null;
    }
  }
}
