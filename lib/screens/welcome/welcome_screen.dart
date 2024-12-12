import 'package:expense_tracker_2/screens/welcome/sign_in.dart';
import 'package:expense_tracker_2/screens/welcome/sign_up.dart';
import 'package:expense_tracker_2/shared/styled_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isSignUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledHeading("Expense Tracker"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Expanded(
            child: SizedBox(
              height: 20,
              child: Center(child: const StyledTitle("Welcome")),
            ),
          ),
          if (_isSignUp)
            Column(
              children: [
                const SignUp(),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = false;
                      });
                    },
                    child: const Text("Already have an account? Sign In!"))
              ],
            ),
          if (!_isSignUp)
            Column(
              children: [
                const SignIn(),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUp = true;
                      });
                    },
                    child: const Text("No account? Sign Up!"))
              ],
            ),
          Expanded(child: SizedBox())
        ],
      ),
    );
  }
}
