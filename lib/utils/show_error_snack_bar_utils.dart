import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

/// Displays a SnackBar with an error message in the given [context].
///
/// The SnackBar shows the [message] text, centered and styled using the
/// `highlightColor` from the application's theme (defined in `AppColors`).
///
/// The SnackBar will be visible for 2 seconds.
///
/// Example usage:
/// ```dart
/// showErrorSnackBar(context, 'Something went wrong');
/// ```
///
/// Parameters:
/// - [context]: The BuildContext to find the [ScaffoldMessenger].
/// - [message]: The error message to be displayed in the SnackBar.
void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
          child:
              Text(message, style: TextStyle(color: AppColors.highlightColor))),
      duration: const Duration(seconds: 2),
    ),
  );
}
