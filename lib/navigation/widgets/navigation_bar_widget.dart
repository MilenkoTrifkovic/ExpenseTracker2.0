import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/providers/page_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarWidget extends ConsumerStatefulWidget {
  const NavigationBarWidget({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  ConsumerState<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends ConsumerState<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  ref.read(pageIndexProvider.notifier).state = index;
                });
              },
              backgroundColor: AppColors.primaryAccent,
              indicatorColor: AppColors.primaryColor,
              selectedIndex: widget.selectedIndex,
              destinations: <Widget>[
                NavigationDestination(
                  icon: Icon(
                    Icons.home,
                    color: AppColors.textColor,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.pie_chart,
                    color: AppColors.textColor,
                  ),
                  label: 'Analysis',
                ),
                NavigationDestination(
                  // enabled: false,
                  icon: Icon(
                    Icons.history,
                    color: AppColors.textColor,
                  ),
                  label: ('History'),
                ),
                NavigationDestination(
                  // enabled: false,
                  icon: Icon(
                    Icons.account_box,
                    color: AppColors.textColor,
                  ),
                  label: ('Account'),
                ),
              ],
            );
  }
}