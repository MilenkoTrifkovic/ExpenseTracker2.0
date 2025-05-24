import 'package:expense_tracker_2/providers/record_store_provider.dart';
import 'package:expense_tracker_2/screens/home/home_screen/widgets/add_record_FAB.dart';
import 'package:expense_tracker_2/screens/home/home_screen/widgets/empty_state_message_widget.dart';
import 'package:expense_tracker_2/screens/home/home_screen/widgets/record_card_widget.dart';
import 'package:expense_tracker_2/widgets/date_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // ref.read(recordsNotifierProvider.notifier).fetchAllRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(recordsNotifierProvider.notifier).fetchAllRecords();
    DateTime selectedPeriod = ref.watch(navigatorDateProvider);
    final loadedRecords = ref.watch(recordsNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity, // Ensures the container fills the width
            height: double.infinity,
            child: Column(
              children: [
                //LOADED RECORDS//
                const DateNavigatorContainer(),
                Expanded(
                    child: loadedRecords.any(
                  (e) =>
                      e.date.month == selectedPeriod.month &&
                      e.date.year == selectedPeriod.year,
                )
                        ? ListView(
                            children: loadedRecords.map(
                            (e) {
                              if (e.date.month == selectedPeriod.month &&
                                  e.date.year == selectedPeriod.year) {
                                return RecordCardWidget(record: e);
                              }
                              return Container();
                            },
                          ).toList())
                        : const EmptyStateMessageWidget()),
              ],
            ),
          ),
          //ADD RECORD BUTTON//
          const AddRecordFAB(),
        ],
      ),
    );
  }
}
