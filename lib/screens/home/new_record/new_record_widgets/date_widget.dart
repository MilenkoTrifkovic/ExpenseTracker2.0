import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This widget uses a [TextField] to show the selected date, which is managed by
/// the [newRecordSelectedDateProvider] Riverpod provider. When tapped, it opens a
/// [showDatePicker] dialog allowing the user to select a date between the years 2000 and 2100.
///
/// Once a date is selected, it is formatted and displayed in the text field,
/// and the provider is updated with the new value.
class DateWidget extends ConsumerStatefulWidget {
  const DateWidget({super.key});

  @override
  ConsumerState<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends ConsumerState<DateWidget> {
  final TextEditingController _dateController = TextEditingController();

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

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = (ref.watch(newRecordSelectedDateProvider));
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                color: AppColors.textColor,
              ),
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: AppColors.textColor),
                  hintText: selectedDate.toString().split(' ')[0],
                  hintStyle:
                      TextStyle(color: AppColors.textColor, fontSize: 16),
                  // filled: true,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.textColor,
                  ),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
              onTap: () async {
                DateTime selectedDate = await _selectDate();
                ref
                    .read(newRecordSelectedDateProvider.notifier)
                    .changeDateAndTime(selectedDate);
              },
            ),
          ),
        ],
      ),
    );
  }
}
