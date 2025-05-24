import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';

/// A widget that displays a transaction record in a styled card format.
///
/// The `RecordCardWidget` shows:
/// - An icon representing the transaction category
/// - The transaction type (e.g., income or expense)
/// - A short description (trimmed to 20 characters if too long)
/// - The transaction date
/// - The transaction amount
///
/// The background color of the card is green for income and red for expenses.
class RecordCardWidget extends StatelessWidget {
  /// The transaction record to display.
  final TransactionRecord record; 
  /// Creates a [RecordCardWidget].
  ///
  /// The [record] parameter must not be null.
  const RecordCardWidget({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: record.transaction == 'income'
          ? const Color.fromARGB(255, 9, 121, 13)
          : const Color.fromARGB(255, 151, 14, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(record.category.icon, height: 60, width: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledHeading(record.transaction),
                StyledText(
                  text: record.description.length > 20
                      ? '${record.description.substring(0, 20)}...'
                      : record.description,
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                StyledText(text: record.date.toString().split(' ')[0]),
                StyledTitle('\$${record.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
