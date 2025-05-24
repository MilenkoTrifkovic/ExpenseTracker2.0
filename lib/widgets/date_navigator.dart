import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'date_navigator.g.dart';

@riverpod
class NavigatorDate extends _$NavigatorDate {
  @override
  DateTime build() => DateTime(DateTime.now().year, DateTime.now().month);
  void moveToNextMonth() {
    state = DateTime(state.year, state.month + 1);
  }

  void moveToPreviousMonth() {
    state = DateTime(state.year, state.month - 1);
  }
}

class DateNavigatorContainer extends ConsumerStatefulWidget {
  const DateNavigatorContainer({super.key});

  @override
  ConsumerState<DateNavigatorContainer> createState() => _DateNavigatorContainerState();
}

class _DateNavigatorContainerState extends ConsumerState<DateNavigatorContainer> {
  @override
  Widget build(BuildContext context) {
    final dateNotifier = ref.read(navigatorDateProvider.notifier);
    final dateProvider = ref.watch(navigatorDateProvider);

    String formattedDate = DateFormat('MMMM yyyy').format(dateProvider);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              dateNotifier.moveToPreviousMonth();
              setState(() {});
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(width: 10),
          StyledHeading(formattedDate),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              dateNotifier.moveToNextMonth();
              setState(() {});
            },
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
