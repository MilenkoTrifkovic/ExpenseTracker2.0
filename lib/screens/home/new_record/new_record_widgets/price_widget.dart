import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/screens/home/new_record/providers/new_record_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceWidget extends ConsumerWidget {
  // final String insertedAmount;
  const PriceWidget({super.key});
  // const PriceWidget({super.key, required this.insertedAmount});

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
                                ref.watch(totalAmountProvider),
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