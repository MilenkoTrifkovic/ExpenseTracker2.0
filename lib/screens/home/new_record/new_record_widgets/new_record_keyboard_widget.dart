import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_keyboard_custom_layout/virtual_keyboard_custom_layout.dart';

// ignore: must_be_immutable
class KeyboardAux extends ConsumerStatefulWidget {
  TextEditingController? controller;
  VirtualKeyboardType typeKeyboard;
  TypeLayout typeLayout;
  bool alwaysCaps;
  // final void Function(String) changeInsertedAmount;
  // final void Function() deleteOneDigitInsertedAmount;
  // final String insertedAmount;
  KeyboardAux({
    Key? key,
    this.alwaysCaps = false,
    this.controller,
    this.typeLayout = TypeLayout.numeric,
    required this.typeKeyboard,
    // required this.changeInsertedAmount,
    // required this.insertedAmount,
    // required this.deleteOneDigitInsertedAmount,
  }) : super(key: key);

  @override
  ConsumerState<KeyboardAux> createState() => _KeyboardAuxState();
}

bool shiftEnabled = false;

class _KeyboardAuxState extends ConsumerState<KeyboardAux> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        color: AppColors.primaryColor,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            color: AppColors.secondaryColor,
            child: LayoutBuilder(builder: (context, constrains) {
              return VirtualKeyboard(
                height: constrains.maxHeight,
                width: constrains.maxWidth,
                // width: MediaQuery.of(context).size.width,
                fontSize: constrains.maxHeight * 0.1,
                textColor: AppColors.textColor,
                textController: widget.controller,
                defaultLayouts: const [
                  VirtualKeyboardDefaultLayouts.English,
                ],
                borderColor: const Color.fromARGB(255, 151, 151, 151),
                type: widget.typeKeyboard,
                onKeyPress: onKeyPress,
              );
            }),
          ),
        ),
      ),
    );
  }

  onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      ref.read(totalAmountProvider.notifier).addLastDigitTotalAmount(key.text!);
    } else {
      ref.read(totalAmountProvider.notifier).removeLastDigitTotalAmount();
    }
  }
}

enum TypeLayout { numeric }

extension TypeLayoutExtension on TypeLayout {
  List<List> get keyboard {
    switch (this) {
      case TypeLayout.numeric:
        return [
          ["1", "2", "3"],
          ["4", "5", "6"],
          ["7", "8", "9"],
          ["BACKSPACE", "0", "RETURN"],
        ];
    }
  }
}
