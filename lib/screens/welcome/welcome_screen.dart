import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/screens/welcome/sign_in.dart';
import 'package:expense_tracker_2/screens/welcome/sign_up.dart';
import 'package:expense_tracker_2/screens/welcome/widgets/facebook_auth.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';

/// A [StatefulWidget] that displays the welcome screen for authentication.
/// This screen allows the user to either sign up or sign in to their account.
/// It also provides an option for logging in via Facebook.

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  /// A flag indicating whether to display the sign-up UI.
  /// If [true], the sign-up form is displayed; if [false], the sign-in form is displayed.
  bool _isSignUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledHeading("Expense Tracker"),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        // color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(child: StyledTitle("Welcome")),
            // ),
            if (_isSignUp) _buildSignUpUI(),
            if (!_isSignUp) _buildSignInUI(),
            const FacebookAuthWidget(),
          ],
        ),
      ),
    );
  }

  // Sign Up UI
  Widget _buildSignUpUI() {
    return Column(
      children: [
        const SignUp(),
        TextButton(
          onPressed: () {
            setState(() {
              _isSignUp = false;
            });
          },
          child:  StyledText(
            text: 'Already have an account? Sign In!',
            textColor: AppColors.highlightColor,
          ),
        ),
      ],
    );
  }

  // Sign In UI
  Widget _buildSignInUI() {
    return Column(
      children: [
        const SignIn(),
        TextButton(
          onPressed: () {
            setState(() {
              _isSignUp = true;
            });
          },
          child: StyledText(
            text: 'Create an account',
            textColor: AppColors.highlightColor,
          ),
        ),
      ],
    );
  }
}
