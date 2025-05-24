import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplaySelectedCategoryWidget extends ConsumerWidget {
  const DisplaySelectedCategoryWidget({super.key});

  /// Displays the selected category icon and name
  /// The icon and name are retrieved from the selected category provider.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(newRecordSelectedCategoryProvider);
    return Row(
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
                selectedCategory.icon,
                width: 50,
                height: 50,
              )),
              FittedBox(
                child: StyledHeading(
                  selectedCategory.categoryName,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
