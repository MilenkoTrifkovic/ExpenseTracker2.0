import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

class DescriptionTextFieldWidget extends StatelessWidget {
  final  TextEditingController descriptionController;
  const DescriptionTextFieldWidget({super.key, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return TextField(
                    onTapOutside: ((event) {
                      FocusScope.of(context).unfocus();
                    }),
                    style: TextStyle(color: AppColors.textColor),
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: AppColors.textColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textColor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textColor)),
                      labelText: 'Description...',
                    ),
                    controller: descriptionController,
                  );
  }
}