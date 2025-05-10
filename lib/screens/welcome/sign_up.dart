import 'package:expense_tracker_2/services/firebase_services/auth_services.dart';
import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor, // Replace with your AppBar color
    ));
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
              if(value == null || value.isEmpty){
                return 'Insert an Email';
              }return null;
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
            decoration: const InputDecoration(label: Text('Password')
            ),
            obscureText: true,
            validator: (value) {
              if(value == null || value.isEmpty){
                return 'Insert a password';
              }return null;
            },
          ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            if(_formKey.currentState!.validate()){
              AuthServices.signUp(_emailController.text, _passwordController.text);
            }
          }, child: const Text("Sign Up"))
        ],
      ),
    ));
  }
}