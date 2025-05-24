import 'package:expense_tracker_2/providers/expense_categories_provider.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/category_matcher.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/select_category_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:expense_tracker_2/utils/show_error_snack_bar_utils.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCategoryBtnWidget extends ConsumerWidget {
  const SelectCategoryBtnWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(newRecordSelectedCategoryProvider);
    final selectedTransactionStatus =
        ref.watch(newRecordSelectedTransactionStatusProvider);
    final loadingStatusNotifier =
        ref.watch(newRecordLoadingStatusProvider.notifier);
    final description = ref.watch(newRecordDescriptionProvider);
    return StyledButton(
        onPressed: () async {
          try {
            loadingStatusNotifier.changeLoadingStatus(true);
            CategoryMatcher categoryMatcher = CategoryMatcher(
              expenseNotifier: ref.read(expenseCategoriesProvider.notifier),
              incomeNotifier: ref.read(incomeCategoriesProvider.notifier),
            );
            await categoryMatcher.categoryMatch(
                transactionStatus: selectedTransactionStatus,
                description: description,
                incomeCategories: ref.read(incomeCategoriesProvider.future),
                expenseCategories: ref.read(expenseCategoriesProvider.future));

            showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) {
                  //displays the categories in a dialog
                  return SelectCategoryWidget(
                    selectedCategory: selectedCategory,
                  );
                });
          } on Exception catch (e) {
            showErrorSnackBar(context, 'Something went wrong! Try again');
          } finally {
            loadingStatusNotifier.changeLoadingStatus(false);
          }
        },
        child: const Text('Select a category'));
  }
}
