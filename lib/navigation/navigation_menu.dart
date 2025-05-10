import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/navigation/widgets/app_bar_widget.dart';
import 'package:expense_tracker_2/navigation/widgets/navigation_bar_widget.dart';
import 'package:expense_tracker_2/navigation/widgets/navigation_rail_widget.dart';
import 'package:expense_tracker_2/providers/page_index_provider.dart';
import 'package:expense_tracker_2/screens/analysis/analysis_screen.dart';
import 'package:expense_tracker_2/screens/transaction_history/all_transactions_from_backend.dart';
import 'package:expense_tracker_2/screens/home/home_screen.dart';
import 'package:expense_tracker_2/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationMenu extends ConsumerStatefulWidget {
  const NavigationMenu({super.key});

  @override
  ConsumerState<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends ConsumerState<NavigationMenu> {
  late double screenWidth;
  final breakpoint = 600;

  final List<Map<String, dynamic>> _pages = [
    {
      'widget': const HomeScreen(),
      'icon': Icon(
        Icons.home,
        color: AppColors.textColor,
      ),
      'label': 'Home',
    },
    {
      'widget': const AnalysisScreen(),
      'icon': Icon(
        Icons.pie_chart,
        color: AppColors.textColor,
      ),
      'label': 'Analysis',
    },
    {
      'widget': const AllTransactionsFromBackend(),
      'icon': Icon(
        Icons.history,
        color: AppColors.textColor,
      ),
      'label': 'history',
    },
    {
      'widget': const ProfileScreen(),
      'icon': Icon(
        Icons.account_box,
        color: AppColors.textColor,
      ),
      'label': 'Account',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor, // Replace with your AppBar color
    ));
    screenWidth = MediaQuery.sizeOf(context).width;
    final int selectedIndex = ref.watch(pageIndexProvider);
    return Scaffold(
      appBar: const AppBarWidget(),
      body: screenWidth > breakpoint
          ? NavigationRailWidget(selectedIndex: selectedIndex, pages: _pages)
          : _pages[selectedIndex]['widget'],
      bottomNavigationBar: screenWidth > breakpoint
          ? null
          : NavigationBarWidget(selectedIndex: selectedIndex),
    );
  }
}
// 