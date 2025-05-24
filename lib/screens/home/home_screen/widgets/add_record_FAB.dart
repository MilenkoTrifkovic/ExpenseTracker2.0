import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record.dart';
import 'package:flutter/material.dart';
/// A floating action button widget that allows users to add a new transaction record.
/// 
/// When pressed, this button navigates to the [NewRecord] screen. It is styled
/// as a circular button and positioned at the bottom-right of the screen.
class AddRecordFAB extends StatelessWidget {
  /// Creates an [AddRecordFAB].
  const AddRecordFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryAccent,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewRecord()),
          );
        },
        child: Icon(Icons.add, color: AppColors.textColor),
      ),
    );
  }
}
