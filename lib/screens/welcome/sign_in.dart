import 'package:expense_tracker_2/services/auth_services.dart';
import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextFormField(
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    AuthServices.signIn(
                        _emailController.text, _passwordController.text);
                  }
                },
                style: TextStyle(color: AppColors.textColor),
                controller: _emailController,
                decoration: const InputDecoration(label: Text('Email')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'try again';
                  }
                  return null;
                },
              ),
              TextFormField(
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    AuthServices.signIn(
                        _emailController.text, _passwordController.text);
                  }
                },
                style: TextStyle(color: AppColors.textColor),
                controller: _passwordController,
                decoration: const InputDecoration(label: Text('Password')),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'try again';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthServices.signIn(
                          _emailController.text, _passwordController.text);
                    }
                  },
                  child: const Text("Sign In"))
            ],
          ),
        ));
  }
}
