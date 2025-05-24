import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

class EmptyStateMessageWidget extends StatelessWidget {
  const EmptyStateMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No records in this month",
        style: TextStyle(
          color: AppColors.textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
