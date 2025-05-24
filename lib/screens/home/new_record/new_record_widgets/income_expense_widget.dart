import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A StatefulWidget that displays two buttons, 'INCOME' and 'EXPENSE',
/// allowing the user to select between different transaction types.
class IncomeExpenseWidget extends ConsumerStatefulWidget {
  const IncomeExpenseWidget({
    super.key,
  });

  @override
  ConsumerState<IncomeExpenseWidget> createState() =>
      _IncomeExpenseWidgetState();
}

class _IncomeExpenseWidgetState extends ConsumerState<IncomeExpenseWidget>
    with TickerProviderStateMixin {
  // The current selected transaction type: either 'income' or 'expense'.
  String _selectedTransaction = 'expense';
  String get selectedTransaction => _selectedTransaction;

  // Animation controllers and animations for 'INCOME' and 'EXPENSE' buttons.
  late AnimationController _controllerIncome;
  late Animation _sizeAnimationIncome;

  late AnimationController _controllerExpense;
  late Animation _sizeAnimationExpense;

  @override
  void initState() {
    super.initState();

    // Initialize 'INCOME' button animation.
    _controllerIncome = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _sizeAnimationIncome = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 16, end: 25), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 25, end: 16), weight: 50),
    ]).animate(_controllerIncome);

    // Initialize 'EXPENSE' button animation.
    _controllerExpense = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _sizeAnimationExpense = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 16, end: 25), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 25, end: 16), weight: 50),
    ]).animate(_controllerExpense);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 'INCOME' Button
          TextButton(
            onPressed: () {
              // Handle income selection
              setState(() {
                _controllerIncome.reset();
                _controllerIncome.forward();
                _selectedTransaction = 'income';

                // Update selected category to the first income category.
                ref
                    .read(newRecordSelectedCategoryProvider.notifier)
                    .changeCategory(incomeCategories[0]);
              });

              // Update transaction status to 'income'.
              ref
                  .read(newRecordSelectedTransactionStatusProvider.notifier)
                  .changeTransactionStatus(TransactionStatus.income);
            },
            child: AnimatedBuilder(
              animation: _controllerIncome,
              builder: (context, child) {
                return Text(
                  "INCOME",
                  style: TextStyle(
                    fontSize: _sizeAnimationIncome.value,
                    color: _selectedTransaction == 'income'
                        ? AppColors.highlightColor
                        : AppColors.textColor,
                  ),
                );
              },
            ),
          ),
          // 'EXPENSE' Button
          TextButton(
            onPressed: () {
              // Handle expense selection
              setState(() {
                _controllerExpense.reset();
                _controllerExpense.forward();
                _selectedTransaction = 'expense';

                // Update selected category to the first expense category.
                ref
                    .read(newRecordSelectedCategoryProvider.notifier)
                    .changeCategory(expenseCategories[0]);
              });

              // Update transaction status to 'expense'.
              ref
                  .read(newRecordSelectedTransactionStatusProvider.notifier)
                  .changeTransactionStatus(TransactionStatus.expense);
            },
            child: AnimatedBuilder(
              animation: _controllerExpense,
              builder: (context, child) {
                return Text(
                  "EXPENSE",
                  style: TextStyle(
                    fontSize: _sizeAnimationExpense.value,
                    color: _selectedTransaction == 'expense'
                        ? AppColors.highlightColor
                        : AppColors.textColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
