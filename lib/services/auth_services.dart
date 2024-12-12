import 'package:expense_tracker_2/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<AppUser?> signUp(String email, String password) async {
    try {
      final UserCredential _userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (_userCredential.user != null) {
        return AppUser(
            email: _userCredential.user!.email!,
            uid: _userCredential.user!.uid);
      }
    } catch (e) {
      return null;
    }
  }
  static Future<AppUser?> signIn(String email, String password)async{
    try{
      final UserCredential _userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(_userCredential.user != null){
          return AppUser(email: _userCredential.user!.email!, uid: _userCredential.user!.uid);
      }
    }catch(e){
      print("Error during sign-in: $e"); // Log the error for debugging
      return null;
    }
  }
  static Future<void> signOut()async{
  try {
      await _firebaseAuth.signOut();
      print("User signed out successfully.");
    } catch (e) {
      print("Error signing out: $e");
      // You can throw or handle the error further if needed.
    }

  }
}
