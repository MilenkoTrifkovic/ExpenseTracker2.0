import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/services/firestore_service.dart';
import 'package:expense_tracker_2/shared/styled_text.dart';
import 'package:expense_tracker_2/theme.dart';
import 'package:flutter/material.dart';

class NewRecord extends StatefulWidget {
  const NewRecord({super.key});

  @override
  State<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> with TickerProviderStateMixin {
  String _selectedTransaction = 'expense';
  DateTime _selectedDate = DateTime.now();
  late Category _selectedCategory;
  String _insertedAmount = '';
  late TransactionRecord _transactionRecord;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
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
    _selectedCategory = expenseCategories[0];
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _controllerExpense.dispose();
    _controllerIncome.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //prevents the keyboard overflow error
        //APP BARR//
        appBar: AppBar(
          automaticallyImplyLeading: false, //removes a back arrow
          title: Row(
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
                      transaction: _selectedTransaction,
                      category: _selectedCategory,
                      description: _descriptionController.text,
                      date: _selectedDate,
                      price: double.parse(_insertedAmount)));
                  Navigator.pop(context);
                },
                child: const StyledHeading('SAVE'),
              ),
            ],
          ),
        ),
        //END OF APP BARR//
        body: GestureDetector(
          onTap: () {
            // FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              //INCOME BUTTON//
              Positioned(
                left: 80,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        _controllerIncome.reset();
                        _controllerIncome.forward();
                        _selectedTransaction = 'income';
                        _selectedCategory = incomeCategories[0];
                      });
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
              ),
              //END OF INCOME BUTTON//
              //EXPENSE BUTTON//
              Positioned(
                right: 80,
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        _controllerExpense.reset();
                        _controllerExpense.forward();
                        _selectedTransaction = 'expense';
                        _selectedCategory = expenseCategories[0];
                      });
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
              ),
              //END OF EXPENSE BUTTON//
              //END OF POSITIONED
              Column(
                children: [
                  //SPACE FOR TRANSACTION BUTTONS//
                  const SizedBox(
                    height: 45,
                  ), 
                  
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.textColor,
                          backgroundColor:
                              AppColors.primaryAccent.withOpacity(0.1)),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: AppColors.primaryAccent.withOpacity(0.9),
                              padding: const EdgeInsets.all(20),
                              child: GridView.count(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                mainAxisSpacing: 40,
                                crossAxisSpacing: 60,
                                crossAxisCount: 2,
                                children: (_selectedTransaction == 'expense'
                                        ? expenseCategories
                                        : incomeCategories)
                                    .map((e) {
                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.5)),
                                      onPressed: () {
                                        setState(() {
                                          _selectedCategory = e;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Icon(Icons.),
                                          Text(
                                            e.categoryName,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ));
                                }).toList(),
                              ),
                            );
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _selectedCategory.icon,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            _selectedCategory.categoryName,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  //END OF CATEGORY SECTION//
                  //DESCRIPTION SECTION

                  TextField(
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
                    controller: _descriptionController,
                  ),

                  //END OF DESCRIPTION SECTION
                  const Expanded(child: SizedBox()),
                  //PRICE SECTION//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _insertedAmount,
                        style: const TextStyle(fontSize: 84),
                      )
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    height: 345,
                    child: GridView.count(
                        childAspectRatio: (6 / 3),
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: [
                          for (int x = 1; x <= 9; x++)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                foregroundColor: Colors.white,
                                shape: const BeveledRectangleBorder(),
                              ),
                              onPressed: () {
                                setState(() {
                                  _insertedAmount =
                                      _insertedAmount + x.toString();
                                });
                              },
                              child: Text(x.toString()),
                            ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              foregroundColor: Colors.white,
                              shape: const BeveledRectangleBorder(),
                            ),
                            onPressed: () {
                              setState(() {
                                _insertedAmount = '$_insertedAmount.';
                              });
                            },
                            child: const Text('.'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              foregroundColor: Colors.white,
                              shape: const BeveledRectangleBorder(),
                            ),
                            onPressed: () {
                              setState(() {
                                _insertedAmount = '${_insertedAmount}0';
                              });
                            },
                            child: const Text('0'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              foregroundColor: Colors.white,
                              shape: const BeveledRectangleBorder(),
                            ),
                            onPressed: () {
                              setState(() {
                                _insertedAmount = _insertedAmount.substring(
                                    0, _insertedAmount.length - 1);
                              });
                            },
                            child: const Icon(Icons.backspace),
                          ),
                        ]),
                  ),

                  //END OF PRICE SECTION//
                  //TIME SECTION//
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                              fillColor: Colors.black.withOpacity(0.3),
                              labelStyle: const TextStyle(color: Colors.white),
                              labelText: 'Date',
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                          onTap: () async {
                            _selectedDate = await _selectDate();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )

                  //END OF TIME SECTION//
                ],
              ),
            ],
          ),
        ));
  }

  Future<DateTime> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        initialDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      _dateController.text = picked.toString().split(' ')[0];
    }
    return picked!;
  }
}
