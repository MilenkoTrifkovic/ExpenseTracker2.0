import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final String transaction;
  final String icon;
  final String description;
  final double price;
  final String date;

  const RecordCard({
    super.key,
    required this.transaction,
    required this.icon,
    required this.description,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: transaction == 'income'
          ? const Color.fromARGB(255, 9, 121, 13)
          : const Color.fromARGB(255, 151, 14, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            icon,
            height: 60,
            width: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledHeading(transaction),
                StyledText(text : description.length > 20
                    ? '${description.substring(0, 20)}...'
                    : description),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                StyledText(text: date.toString().split(' ')[0]),
                StyledTitle('\$${price.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
