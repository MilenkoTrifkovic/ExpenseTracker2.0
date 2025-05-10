import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:expense_tracker_2/services/firebase_services/firestore_service.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveCancelRowWidget extends ConsumerWidget {
  final String selectedTransaction;
  final TransactionCategory selectedCategory;
  final String descriptionController;
  final DateTime selectedDate;
  const SaveCancelRowWidget(
      {super.key,
      required this.selectedTransaction,
      required this.selectedCategory,
      required this.descriptionController,
      required this.selectedDate,
      });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final String insertedAmount = ref.watch(totalAmountProvider);

    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const StyledHeading('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                FirestoreService.addRecord(TransactionRecord(
                    transaction: selectedTransaction,
                    category: selectedCategory,
                    description: descriptionController,
                    date: selectedDate,
                    price: double.parse(insertedAmount)));
                Navigator.pop(context);
              },
              child: const StyledHeading('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}
