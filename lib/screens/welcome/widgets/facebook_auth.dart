import 'package:expense_tracker_2/services/firebase_services/auth_services.dart';
import 'package:flutter/material.dart';

class FacebookAuthWidget extends StatefulWidget {
  const FacebookAuthWidget({super.key});

  @override
  State<FacebookAuthWidget> createState() => _FacebookAuthWidgetState();
}

class _FacebookAuthWidgetState extends State<FacebookAuthWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
  final loginResult = await AuthServices.signInWithFacebook();

  // Ensure the widget is still mounted before using the context
  if (!mounted) return;

  if (loginResult == null) {
    const snackBar = SnackBar(
      content: Center(child: Text('Unable to log in with Facebook!')),
    );
    // Context shouldn't be used In Asynchronousfunction function
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
},
      icon: const Icon(Icons.facebook, color: Colors.white),
      label: const Text(
        'Continue with Facebook',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1877F2), // Facebook Blue
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
