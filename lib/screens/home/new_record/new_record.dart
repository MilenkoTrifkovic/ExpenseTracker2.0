import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:expense_tracker_2/providers/expense_categories_provider.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/category_matcher.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/date_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/description_text_field_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/income_expense_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/new_record_keyboard_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/price_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/save_cancel_row_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/select_category_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/take_a_photo_btn.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_button.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard_custom_layout/virtual_keyboard_custom_layout.dart';

class NewRecord extends ConsumerStatefulWidget {
  const NewRecord({super.key});

  @override
  ConsumerState<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends ConsumerState<NewRecord>
    with TickerProviderStateMixin {
  TransactionStatus _selectedTransactionStatus = TransactionStatus.expense;
  final DateTime _selectedDate = DateTime.now();
  late TransactionCategory _selectedCategory;
  // String _totalAmount = ;
  late Future<void> _matchingFuture;
  bool matchingFutureJustInitialized = false;
  bool selectCategoryBtnPressed = false;
  bool _isLoading = false;

//CONTROLERS//
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  //METHODS//
  void changeCategory(TransactionCategory newCategory) {
    setState(() {
      _selectedCategory = newCategory;
    });
  }

  // void addLastDigitTotalAmount(String character) {
  //   setState(() {
  //     _totalAmount += character;
  //   });
  // }

  // void removeLastDigitTotalAmount() {
  //   setState(() {
  //     _totalAmount = _totalAmount.substring(0, _totalAmount.length - 1);
  //   });
  // }

  // void setTotalAmount(double totalAmount) {
  //   setState(() {
  //     _totalAmount = totalAmount.toString();
  //   });
  // }

  void setSelectedDate(DateTime? selectedDate) {
    setState(() {
      if (selectedDate == null) {
        return;
      }
      _dateController.text = selectedDate.toString().split(' ')[0];
    });
  }

  void setDescription(String description) {
    setState(() {
      _descriptionController.text = description;
    });
  }

  void changeTransactionStatus(TransactionStatus transactionStatus) {
    setState(() {
      _selectedTransactionStatus = transactionStatus;
    });
  }

  void changeLoadingStatus(bool loadingStatus) {
    setState(() {
      _isLoading = loadingStatus;
    });
  }

  Future<void> _machingFutureInitialization() async {
    return;
  }

  @override
  void initState() {
    super.initState();
    _selectedCategory = expenseCategories[0];
    _matchingFuture = _machingFutureInitialization();
    matchingFutureJustInitialized = true;
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            // FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Column(
              children: [
                SaveCancelRowWidget(
                  selectedTransaction: _selectedTransactionStatus.name,
                  selectedCategory: _selectedCategory,
                  descriptionController: _descriptionController.text,
                  selectedDate: _selectedDate,
                ),
                Expanded(
                  child: Stack(
                    //The stack is used because of the animation//
                    children: [
                      //ANIMATION//
                      IncomeExpenseWidget(
                        changeCategory: changeCategory,
                        changeTransactionStatus: changeTransactionStatus,
                      ),
                      Column(
                        children: [
                          //SPACE FOR TRANSACTION BUTTONS//
                          const SizedBox(
                            height: 45,
                          ),

                          //DESCRIPTION SECTION
                          DescriptionTextFieldWidget(
                              descriptionController: _descriptionController),
                          //CATEGORY SECTION//
                          StyledButton(
                              onPressed: () async {
                                CategoryMatcher categoryMatcher =
                                    CategoryMatcher(
                                  expenseNotifier: ref
                                      .read(expenseCategoriesProvider.notifier),
                                  incomeNotifier: ref
                                      .read(incomeCategoriesProvider.notifier),
                                );
                                _matchingFuture = categoryMatcher.categoryMatch(
                                    transactionStatus:
                                        _selectedTransactionStatus,
                                    description: _descriptionController.text,
                                    incomeCategories: ref
                                        .read(incomeCategoriesProvider.future),
                                    expenseCategories: ref.read(
                                        expenseCategoriesProvider.future));
                                selectCategoryBtnPressed = true;
                                setState(() {});
                              },
                              child: const Text('Select a category')),
                          FutureBuilder(
                              future: _matchingFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // changeLoadingStatus(true);
                                  return Text('');
                                  // return CircularProgressIndicator(
                                  //   color: AppColors.primaryAccent,
                                  // ); // Show loading indicator
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  // changeLoadingStatus(false);
                                  //The if statemant prevents the dialog from being shown after
                                  //loading a widget for the first time and rebuilding a widget
                                  //There might be a better solution for this
                                  if (matchingFutureJustInitialized == false &&
                                      selectCategoryBtnPressed == true) {
                                    selectCategoryBtnPressed = false;
                                    // matchingFutureJustInitialized = true;
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                      (_) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SelectCategoryWidget(
                                                selectedTransactionStatus:
                                                    _selectedTransactionStatus,
                                                changeCategory: changeCategory,
                                                selectedCategory:
                                                    _selectedCategory,
                                                transactionStatus:
                                                    _selectedTransactionStatus,
                                              );
                                            });
                                      },
                                    );
                                  } else {
                                    matchingFutureJustInitialized = false;
                                  }
                                  return Container();
                                } else {
                                  return const Text('');
                                }
                              }),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Column(
                                  children: [
                                    FittedBox(
                                        child: Image.asset(
                                      _selectedCategory.icon,
                                      width: 50,
                                      height: 50,
                                    )),
                                    FittedBox(
                                      child: StyledHeading(
                                        _selectedCategory.categoryName,
                                        // style:  TextStyle(
                                        //     color: AppColors.textColor,
                                        //     fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          //END OF CATEGORY SECTION//

                          //PRICE SECTION//
                          PriceWidget(),
                          // PriceWidget(insertedAmount: _totalAmount),

                          KeyboardAux(
                            typeKeyboard: VirtualKeyboardType.Numeric,
                          ),

                          //BOTTOM SECTION//

                          Row(
                            children: [
                              DateWidget(
                                  dateController: _dateController,
                                  setSelectedDate: setSelectedDate),
                              if (_selectedTransactionStatus ==
                                  TransactionStatus.expense)
                                StyledText(
                                  text: "Scan a reciept",
                                  textColor:
                                      AppColors.textColor.withOpacity(0.5),
                                ),
                              if (_selectedTransactionStatus ==
                                  TransactionStatus.expense)
                                TakeAPhotoBtn(
                                  setDate: setSelectedDate,
                                  // setTotalAmount: setTotalAmount,
                                  setDescription: setDescription,
                                  changeLoadingStatus: changeLoadingStatus,
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )

                          //END OF TIME BOTTOM SECTION//
                        ],
                      ),
                      if (_isLoading)
                        Positioned(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: AppColors.highlightColor,
                          )),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
