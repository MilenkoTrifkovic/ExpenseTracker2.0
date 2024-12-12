import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor =
      const Color.fromRGBO(30, 30, 30, 1); // Very dark background
  static Color primaryAccent =
      const Color.fromARGB(64, 109, 97, 59); // Dark orange accent
  static Color secondaryColor = const Color.fromRGBO(
      45, 45, 45, 1); // Darker grey for cards or containers
  static Color secondaryAccent =
      const Color.fromRGBO(60, 40, 30, 1); // Muted dark orange
  static Color titleColor =
      const Color.fromRGBO(230, 230, 230, 1); // Light grey for titles
  static Color textColor =
      const Color.fromRGBO(200, 200, 200, 1); // Lighter grey for general text
  static Color successColor =
      const Color.fromRGBO(20, 110, 90, 1); // Muted green for success
  static Color highlightColor = const Color.fromRGBO(
      200, 100, 20, 1); // Bright dark orange for highlights
}

ThemeData primaryTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.secondaryColor,
    appBarTheme: AppBarTheme(color: AppColors.primaryColor),
    navigationBarTheme: NavigationBarThemeData(
        labelTextStyle:
            MaterialStateProperty.all(TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    cardTheme: CardTheme(
      color: AppColors.secondaryAccent,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 16),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 16,
        letterSpacing: 1,
      ),
      headlineMedium: TextStyle(
        color: AppColors.titleColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
      titleMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ));
