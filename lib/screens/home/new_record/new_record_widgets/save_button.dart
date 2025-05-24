import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:expense_tracker_2/services/firebase_services/firestore_service.dart';
import 'package:expense_tracker_2/utils/show_error_snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String insertedAmount = ref.watch(newRecordTotalAmountProvider);
    final selectedCategory = ref.watch(newRecordSelectedCategoryProvider);
    final selectedDate = ref.watch(newRecordSelectedDateProvider);
    final selectedDescription = ref.watch(newRecordDescriptionProvider);

    return IconButton(
      onPressed: insertedAmount == '' || selectedDescription == ''
          ? null
          : () {
              try {
                FirestoreService.addRecord(TransactionRecord(
                    transaction: ref
                        .read(newRecordSelectedTransactionStatusProvider)
                        .name,
                    category: selectedCategory,
                    description: selectedDescription,
                    date: selectedDate,
                    price: double.parse(insertedAmount)));
                Navigator.pop(context);
              } on Exception catch (e) {
                showErrorSnackBar(
                    context, 'Something went wrong! Try again');
              }
            },
      icon: Icon(
        Icons.check,
        color: insertedAmount == '' || selectedDescription == ''
            ? Colors.grey.withOpacity(0.5)
            : null,
      ),
    );
  }
}
