import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_2/shared/styled_text.dart';
import 'package:expense_tracker_2/theme.dart';

class DateNavigatorContainer extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const DateNavigatorContainer({
    super.key,
    required this.selectedDate,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM yyyy').format(selectedDate);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: onPrevious,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(width: 10),
          StyledHeading(formattedDate),
          const SizedBox(width: 10),
          TextButton(
            onPressed: onNext,
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
