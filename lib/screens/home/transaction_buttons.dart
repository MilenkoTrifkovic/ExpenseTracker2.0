import 'package:flutter/material.dart';

class TransactionButtons extends StatefulWidget {
  const TransactionButtons({super.key});

  @override
  State<TransactionButtons> createState() => _TransactionButtonsState();
}

class _TransactionButtonsState extends State<TransactionButtons>
    with TickerProviderStateMixin {
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
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _sizeAnimationIncome = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween(begin: 16, end: 25), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 25, end: 16), weight: 50),
    ]).animate(_controllerIncome);
    //END OF INCOME BUTTON//
    //EXPENSE BUTTON//
    _controllerExpense =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _sizeAnimationExpense = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 16, end: 25), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 25, end: 16), weight: 50),
    ]).animate(_controllerExpense);
    //END OF EXPENSE BUTTON//

    super.initState();
  }

  @override
  static late String selectedTransaction;
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //INCOME BUTTON//
        TextButton(
            onPressed: () {
              setState(() {
                _controllerIncome.reset();
                _controllerIncome.forward();
                selectedTransaction = 'income';
              });
            },
            child: AnimatedBuilder(
              animation: _controllerIncome,
              builder: (context, child) {
                return Text(
                  "INCOME",
                  style: TextStyle(fontSize: _sizeAnimationIncome.value),
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
                selectedTransaction = 'expense';
              });
            },
            child: AnimatedBuilder(
              animation: _controllerExpense,
              builder: (context, child) {
                return Text(
                  "EXPENSE",
                  style: TextStyle(fontSize: _sizeAnimationExpense.value),
                );
              },
            )),
        //END OF EXPENSE BUTTON//
      ],
    );
  }
}
