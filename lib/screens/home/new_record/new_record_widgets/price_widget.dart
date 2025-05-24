import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that displays the total inserted amount aligned to the right.
///
/// This widget uses [newRecordTotalAmountProvider] to get the current
/// amount, and adjusts its font size based on available height using
/// [LayoutBuilder]. It is wrapped in an [Expanded] to fit flexibly
/// in its parent layout.
class PriceWidget extends ConsumerWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 1,
      child: Container(
        color: AppColors.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  ref.watch(newRecordTotalAmountProvider),
                  // insertedAmount,
                  style: TextStyle(
                    fontSize: constraints.maxHeight * 0.5,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
