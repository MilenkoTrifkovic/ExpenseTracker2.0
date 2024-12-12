import 'package:expense_tracker_2/models/app_user.dart';
import 'package:expense_tracker_2/providers/auth_proider.dart';
import 'package:expense_tracker_2/screens/welcome/welcome_screen.dart';
import 'package:expense_tracker_2/navigation_menu.dart';
import 'package:expense_tracker_2/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child:  MyApp()));
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: primaryTheme,
      home: Consumer(builder: (context, ref, child) {
        AsyncValue<AppUser?> user = ref.watch(authProvider);
        return user.when(
          data: (user) {
            if(user == null){
              return WelcomeScreen();
            }return const NavigationMenu();
          }, 
        error: (error, stackTrace) => const Text("error loading"), 
        loading: () => const Text("Loading"),);
      },)
    );
  }
}
