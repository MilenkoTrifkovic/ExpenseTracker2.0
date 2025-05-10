import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.child, required this.onPressed, this.disabled});
  final onPressed;
  final Widget child;
  final bool? disabled;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled==true? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryAccent,
        foregroundColor: AppColors.titleColor
      ),
      child: child,
    );
  }
}
