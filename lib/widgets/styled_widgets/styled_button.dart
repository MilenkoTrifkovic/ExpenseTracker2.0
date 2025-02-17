import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  const StyledButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return 
    ElevatedButton(
      onPressed: onPressed(),
      child: child,
      // style:
      //     ElevatedButton.styleFrom(iconColor: Colors.red),
    );
  }
}
