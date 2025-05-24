import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/navigation/widgets/app_bar_widget.dart';
import 'package:expense_tracker_2/navigation/widgets/navigation_bar_widget.dart';
import 'package:expense_tracker_2/navigation/widgets/navigation_rail_widget.dart';
import 'package:expense_tracker_2/providers/page_index_provider.dart';
import 'package:expense_tracker_2/screens/analysis/analysis_screen.dart';
import 'package:expense_tracker_2/screens/transaction_history/all_transactions_from_backend.dart';
import 'package:expense_tracker_2/screens/home/home_screen/home_screen.dart';
import 'package:expense_tracker_2/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A responsive widget that provides the main navigation menu for the app.
///
/// Displays either a [NavigationRailWidget] or a [NavigationBarWidget]
/// depending on the screen width.
///
/// - If the screen width is greater than 600 pixels, it shows a side rail.
/// - Otherwise, it shows a bottom navigation bar.
///
/// This widget uses Riverpod to watch the selected page index via [pageIndexProvider],
/// and loads the corresponding screen from a list of available pages:
/// - Home
/// - Analysis
/// - Transaction History
/// - Profile
///
/// Each page is defined with a corresponding icon and label.
class NavigationMenu extends ConsumerStatefulWidget {
  const NavigationMenu({super.key});

  @override
  ConsumerState<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends ConsumerState<NavigationMenu> {
  late double screenWidth;
  final breakpoint = 600;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor, // Replace with your AppBar color
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  /// A list of pages used in the navigation menu.
  ///
  /// Each page includes:
  /// - `widget`: the screen widget to display
  /// - `icon`: the navigation icon
  /// - `label`: a string label for the item
  List<Map<String, dynamic>> get _pages {
    return [
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
  }
//
}
