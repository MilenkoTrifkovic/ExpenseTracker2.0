import 'package:expense_tracker_2/Theme/date_picker_theme.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor =
      const Color.fromRGBO(15, 15, 15, 1); // Deep black for the background
  static Color primaryAccent =
      const Color.fromRGBO(180, 85, 30, 1); // Deep dark orange
  static Color secondaryColor =
      const Color.fromRGBO(25, 25, 25, 1); // Dark grey for containers/cards
  static Color secondaryAccent =
      const Color.fromRGBO(140, 65, 25, 1); // Muted dark orange variation
  static Color titleColor =
      const Color.fromRGBO(230, 220, 210, 1); // Warm off-white for titles
  static Color textColor =
      const Color.fromRGBO(200, 190, 180, 1); // Soft beige for readability
  static Color successColor =
      const Color.fromRGBO(40, 160, 120, 1); // Rich teal-green for success
  static Color highlightColor =
      const Color.fromRGBO(200, 90, 40, 1); // Strong dark orange for highlights
  static Color surfaceColor =
      const Color.fromRGBO(35, 35, 35, 1); // Dark grey for surfaces
}

ThemeData primaryTheme = ThemeData(
    datePickerTheme: DatePickerThemeConfig.getTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.secondaryColor,
    appBarTheme: AppBarTheme(color: AppColors.primaryColor),
    navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
    cardTheme: CardTheme(
      color: AppColors.secondaryColor,
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
