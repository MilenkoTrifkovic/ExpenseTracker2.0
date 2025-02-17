import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';
//It should be adjusted better
class DatePickerThemeConfig {
  static DatePickerThemeData getTheme() {
    return DatePickerThemeData(
      // Year text foreground color
      yearForegroundColor: WidgetStatePropertyAll(AppColors.textColor),

      // Background color for the date picker
      backgroundColor: AppColors.surfaceColor,

      // Foreground color for day numbers
      dayForegroundColor: WidgetStatePropertyAll(AppColors.textColor),

      // Year overlay color
      yearOverlayColor: WidgetStatePropertyAll(AppColors.secondaryColor),

      // Header customization: background and text colors
      headerBackgroundColor: AppColors.surfaceColor,
      headerForegroundColor: AppColors.textColor,

      // Style for weekdays (color of the weekday names)
      weekdayStyle: TextStyle(color: AppColors.textColor),

      // Day selection customization: selected day background
      // dayBackgroundColor: WidgetStatePropertyAll(AppColors.primaryAccent), // Uncomment if needed

      // Color for highlighted day (hovered or focused)
      dayOverlayColor: WidgetStatePropertyAll(AppColors.secondaryColor),

      // Today’s day customization
      todayBackgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),

      // Input field decoration (used in date picker fields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondaryColor,
        hintStyle: TextStyle(color: AppColors.textColor),
      ),
    );
  }
}
