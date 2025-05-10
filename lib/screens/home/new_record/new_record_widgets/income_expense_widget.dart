import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:flutter/material.dart';

class IncomeExpenseWidget extends StatefulWidget {
  final Function(TransactionCategory) changeCategory; // Callback to parent
  final Function(TransactionStatus)
      changeTransactionStatus; // Callback to parent
  const IncomeExpenseWidget(
      {super.key,
      required this.changeCategory,
      required this.changeTransactionStatus});

  @override
  State<IncomeExpenseWidget> createState() => _IncomeExpenseWidgetState();
}

class _IncomeExpenseWidgetState extends State<IncomeExpenseWidget>
    with TickerProviderStateMixin {
  String _selectedTransaction = 'expense';
  String get selectedTransaction => _selectedTransaction;

  //INCOME BUTTON//

  late AnimationController _controllerIncome;
  late Animation _sizeAnimationIncome;
  //END OF INCOME BUTTON//
  //EXPENSE BUTTON//
  late AnimationController _controllerExpense;
  late Animation _sizeAnimationExpense;
  //END OF EXPENSE BUTTON//

  @override
  void initState() {
    //INCOME BUTTON//
    _controllerIncome = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _sizeAnimationIncome = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 16, end: 25), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 25, end: 16), weight: 50),
    ]).animate(_controllerIncome);
    //END OF INCOME BUTTON//
    //EXPENSE BUTTON//
    _controllerExpense = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _sizeAnimationExpense = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 16, end: 25), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 25, end: 16), weight: 50),
    ]).animate(_controllerExpense);
    //END OF EXPENSE BUTTON//
    //FITST CATEGORY SELECTED
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //INCOME BUTTON//
          TextButton(
              onPressed: () {
                setState(() {
                  _controllerIncome.reset();
                  _controllerIncome.forward();
                  _selectedTransaction = 'income';
                  widget.changeCategory(incomeCategories[0]);
                });
                widget.changeTransactionStatus(TransactionStatus.income);
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
                            : AppColors.textColor),
                  );
                },
              )),
          //END OF INCOME BUTTON//
          //EXPENSE BUTTON//
          TextButton(
              onPressed: () {
                setState(() {
                  _controllerExpense.reset();
                  _controllerExpense.forward();
                  _selectedTransaction = 'expense';
                  widget.changeCategory(expenseCategories[0]);
                });
                widget.changeTransactionStatus(TransactionStatus.expense);
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
                            : AppColors.textColor),
                  );
                },
              )),
          // END OF EXPENSE BUTTON//
        ],
      ),
    );
  }
}
