import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A Stateful widget that displays a text field for entering a description.
/// It synchronizes the input with the `newRecordDescriptionProvider` from Riverpod.
class DescriptionTextFieldWidget extends ConsumerStatefulWidget {
  const DescriptionTextFieldWidget({super.key});

  @override
  ConsumerState<DescriptionTextFieldWidget> createState() =>
      _DescriptionTextFieldWidgetState();
}

/// The state class for the `DescriptionTextFieldWidget`. It manages the text input
/// and synchronizes it with the `newRecordDescriptionProvider`.
class _DescriptionTextFieldWidgetState
    extends ConsumerState<DescriptionTextFieldWidget> {
  /// Controller for managing the text input in the description text field.
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    /// Disposes of the text controller when the widget is removed from the tree.
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Synchronizes the text controller with the current description in the provider.
    _descriptionController.text = ref.watch(newRecordDescriptionProvider);

    return TextField(
      /// When tapping outside of the text field, it dismisses the keyboard.
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      style: TextStyle(color: AppColors.textColor), // Sets the text color.
      maxLines: 4, // Allows for up to 4 lines of text.
      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.textColor),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColor)),
        labelText: 'Description...',
      ),
      controller: _descriptionController,

      /// When the text is changed, it updates the `newRecordDescriptionProvider`.
      onChanged: (value) {
        ref
            .read(newRecordDescriptionProvider.notifier)
            .changeDescription(value);
      },
    );
  }
}
