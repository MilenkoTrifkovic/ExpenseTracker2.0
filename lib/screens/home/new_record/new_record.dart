import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/models/transaction_type.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/date_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/description_text_field_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/display_selected_category_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/income_expense_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/new_record_keyboard_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/price_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/save_button.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/select_category_btn_widget.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record_widgets/take_a_photo_btn.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard_custom_layout/virtual_keyboard_custom_layout.dart';

/// A form screen for creating a new financial record (either an expense or income).
///
/// This screen allows users to input details of a transaction, including:
/// - A description of the transaction (via a text field),
/// - Selection of the transaction's category (via a button),
/// - The amount of the transaction (via a custom numeric keyboard),
/// - The transaction's date (via a date picker),
/// - Optionally, the user can scan a receipt to autofill the transaction details.
///
/// The screen dynamically adjusts based on the type of transaction (expense or income).
/// For expenses, the user is prompted to scan a receipt for automatic data entry.
///
/// State management is handled using Riverpod, allowing for modular state updates and easier testing.
/// The screen layout is responsive and contains several animated transitions for a smoother UX.
///
class NewRecord extends ConsumerStatefulWidget {
  const NewRecord({super.key});

  @override
  ConsumerState<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends ConsumerState<NewRecord> {
  @override
  Widget build(BuildContext context) {
    final selectedTransactionStatus =
        ref.watch(newRecordSelectedTransactionStatusProvider);
    return Scaffold(
        appBar: AppBar(
          actions: const [
            SaveButton(),
          ],
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: AppColors.titleColor, // Changes the back button color
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  //The stack is used because of the animation//
                  //to avoid pushing the other widgets during the animation//
                  //The stack is used to show the circular progress indicator
                  children: [
                    //INCOME EXPENSE BUTTONS
                    const IncomeExpenseWidget(),
                    Column(
                      children: [
                        //Create a space for Income/Expense buttons because
                        //they are beyond the Column in the Stack
                        const SizedBox(
                          // height: 45,
                          height: kToolbarHeight * 0.8
                        ),

                        //DESCRIPTION SECTION
                        const DescriptionTextFieldWidget(),
                        //CATEGORY SECTION//
                        const SelectCategoryBtnWidget(),
                        const DisplaySelectedCategoryWidget(),

                        //PRICE SECTION//
                        const PriceWidget(),
                        //KEYBOARD SECTION//
                        //This is a custom keyboard that is not the most appropriate
                        //It should be replaced with a more appropriate one
                        KeyboardAux(
                          typeKeyboard: VirtualKeyboardType.Numeric,
                        ),

                        //BOTTOM SECTION//
                        Row(
                          children: [
                            const DateWidget(),
                            //If statement makes sure that the button is only shown
                            //if the selected transaction status is expense
                            if (selectedTransactionStatus ==
                                TransactionStatus.expense)
                              StyledText(
                                text: "Scan a receipt",
                                textColor: AppColors.textColor.withOpacity(0.5),
                              ),
                            if (selectedTransactionStatus ==
                                TransactionStatus.expense)
                              const ScanReceiptBtn(),
                          ],
                        ),

                        //CIRCULAR PROGRESS INDICATIOR//
                      ],
                    ),
                    if (ref.watch(newRecordLoadingStatusProvider))
                      Positioned.fill(
                        child: AbsorbPointer(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: AppColors.highlightColor,
                          )),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
