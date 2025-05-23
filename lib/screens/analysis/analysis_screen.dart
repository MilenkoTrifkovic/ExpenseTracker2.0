import 'package:expense_tracker_2/models/category.dart';
import 'package:expense_tracker_2/models/record.dart';
import 'package:expense_tracker_2/providers/record_store_provider.dart';
import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/widgets/date_navigator.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalysisScreen extends ConsumerStatefulWidget {
  const AnalysisScreen({super.key});

  @override
  ConsumerState<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends ConsumerState<AnalysisScreen> {
  final List<Widget> fruits = <Widget>[
    const Text('Income'),
    const Text('Expense'),
  ];
  final List<bool> _selectedButtons = <bool>[true, false];
  String _transactionType = 'income';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const DateNavigatorContainer(),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < _selectedButtons.length; i++) {
                    _selectedButtons[i] = i == index;
                  }
                  index == 0
                      ? _transactionType = 'income'
                      : _transactionType = 'expense';
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              selectedBorderColor: AppColors.highlightColor,
              selectedColor: AppColors.textColor,
              fillColor: Colors.transparent,
              color: Colors.grey,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedButtons,
              children: fruits,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildPieChart(),
            ),
          ],
        ),
      ),
    );
  }

//PIE CHART FUNCTIONS//
  Widget _buildPieChart() {
    return Center(
      child: LayoutBuilder(builder: (context, constrains) {
        return PieChart(PieChartData(
          sections: pieChartSection(
              transaction: _transactionType, constrains: constrains),
          sectionsSpace: 1,
          centerSpaceRadius: 0,
        ));
      }),
    );
  }

  List<PieChartSectionData> pieChartSection(
      {required String transaction, required BoxConstraints constrains}) {
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.brown,
      Colors.green
    ];
    Set<TransactionRecord> records = ref.watch(recordsNotifierProvider);
    DateTime selectedPeriod = ref.watch(navigatorDateProvider);

    Map<String, double> balance = {};
    for (var rec in records.where((element) =>
        element.transaction == transaction &&
        element.date.month == selectedPeriod.month)) {
      balance.update(
        rec.category.categoryName,
        (existingValue) => existingValue + rec.price,
        ifAbsent: () => rec.price,
      );
    }
    return List.generate(
      balance.length,
      (index) {
        var entry = balance.entries.elementAt(index);
        return PieChartSectionData(
            // There will be an exception if the Pie charts don't have the same number of slices
            //Enabled animation could be a problem
            value: entry.value,
            color: colors[index],
            radius: constrains.maxWidth < constrains.maxHeight
                ? constrains.maxWidth * 0.35
                : constrains.maxHeight * 0.35,
            title: entry.value.toString(),
            titleStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            titlePositionPercentageOffset: 0.65,
            badgePositionPercentageOffset: 1.4,
            borderSide: const BorderSide(color: Colors.white, width: 2),
            badgeWidget: transaction == 'expense'
                ? SizedBox(
                    height: 80,
                    width: 80,
                    child: Column(
                      children: [
                        Image.asset(
                          (expenseCategories.firstWhere(
                              (e) => e.categoryName == entry.key.toString())).icon,
                        ),
                        StyledText(text: entry.key.toString(), textColor: Colors.white,),
                      ],
                    ),
                  )
                :  SizedBox(
                    height: 80,
                    width: 80,
                    child: Column(
                      children: [
                        Image.asset(
                          (incomeCategories.firstWhere(
                              (e) => e.categoryName == entry.key.toString())).icon,
                        ),
                        StyledText(text: entry.key.toString(), textColor: Colors.white,),
                      ],
                    ),
                  ));
      },
    );
  }
}
