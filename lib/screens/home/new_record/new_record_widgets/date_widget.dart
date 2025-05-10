import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  // final DateTime selectedDate;
  final void Function(DateTime?) setSelectedDate;
  final TextEditingController dateController;
  const DateWidget(
      {super.key, required this.dateController, required this.setSelectedDate});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  Future<DateTime> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        initialDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      widget.dateController.text = picked.toString().split(' ')[0];
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                color: AppColors.textColor,
              ),
              controller: widget.dateController,
              readOnly: true,
              decoration: InputDecoration(
                  // fillColor: Colors.black.withOpacity(0.3),
                  labelStyle: TextStyle(color: AppColors.textColor),
                  // labelText: "Date",
                  // hintText: DateFormat('yyy-MM-dd').format(_selectedDate),
                  hintText: "Date",
                  hintStyle: TextStyle(color: AppColors.textColor, fontSize: 16 ),
                  // filled: true,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.textColor,
                  ),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))
                      ),
              onTap: () {
                setState(() async {
                  widget.setSelectedDate(await _selectDate());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
