import 'package:expense_tracker_2/providers/record_store_provider.dart';
import 'package:expense_tracker_2/screens/home/new_record/new_record.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/widgets/date_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentPageIndex = 0;
  bool ifCardsExist = false;

  DateTime selectedPeriod = DateTime.now();

  //DATE NAVIGATOR FUNCTIONS//
  void _moveToNextMonth() {
    setState(() {
      selectedPeriod = DateTime(
          selectedPeriod.year, selectedPeriod.month + 1, selectedPeriod.day);
    });
  }

  void _moveToPreviousMonth() {
    setState(() {
      selectedPeriod = DateTime(
          selectedPeriod.year, selectedPeriod.month - 1, selectedPeriod.day);
    });
  }
  //END OF DATE NAVIGATOR FUNCTIONS//

  @override
  void initState() {
    ref.read(recordsNotifierProvider.notifier).fetchAllRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 5,
                ),
                //LOADED RECORDS//
                DateNavigatorContainer(
                    selectedDate: selectedPeriod,
                    onPrevious: _moveToPreviousMonth,
                    onNext: _moveToNextMonth),
                const SizedBox(
                  height: 5,
                ),
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
                              return Card(
                                color: e.transaction == 'income'
                                    ? const Color.fromARGB(255, 9, 121, 13)
                                    : const Color.fromARGB(255, 151, 14, 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      e.category.icon,
                                      height: 60,
                                      width: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          StyledHeading(e.transaction),
                                          StyledText(
                                              text: e.description.length > 20
                                                  ? '${e.description.substring(0, 20)}...'
                                                  : e.description),
                                        ],
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        children: [
                                          StyledText(
                                            text:
                                                e.date.toString().split(' ')[0],
                                          ),
                                          StyledTitle(
                                              '\$${e.price.toStringAsFixed(2)}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          },
                        ).toList())
                      : Center(
                          child: Text(
                            "No records in this month",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                ),
                //END OF LOADED RECORDS//
              ],
            ),
          ),
          //ADD RECORD BUTTON//
          Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryAccent,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewRecord(),
                      ));
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.textColor,
                ),
              )),
          //END OF ADD RECORD BUTTON//
        ],
      ),
    );
  }
}
