import 'package:expense_tracker_2/screens/analysis/analysis_screen.dart';
import 'package:expense_tracker_2/screens/all_transactions_from_backend.dart';
import 'package:expense_tracker_2/screens/home/home_screen.dart';
import 'package:expense_tracker_2/screens/profile/profile_screen.dart';
import 'package:expense_tracker_2/services/auth_services.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentPageIndex = 0;

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;
  bool extendNavRail = false;
  IconData extendedNavRailIcon = Icons.menu;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AnalysisScreen(),
    const AllTransactionsFromBackend(),
    const ProfileScreen()
  ];
  List<NavigationRailDestination> navigationDestinations = [
    const NavigationRailDestination(
      icon: Icon(
        Icons.home,
        color: Colors.white,
      ),
      label: StyledHeading('Home'),
    ),
    const NavigationRailDestination(
      icon: Icon(
        Icons.pie_chart,
        color: Colors.white,
      ),
      label: StyledHeading('Settings'),
    ),
    const NavigationRailDestination(
      // enabled: false,
      icon: Icon(
        Icons.history,
        color: Colors.white,
      ),
      label: StyledHeading('History'),
    ),
    const NavigationRailDestination(
      // enabled: false,
      icon: Icon(
        Icons.account_box,
        color: Colors.white,
      ),
      label: StyledHeading('Account'),
    ),
    // Add more destinations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          color: AppColors.primaryColor,
          child: Stack(
            // Nastaviti raditi sa AppBar
            children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.03),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: StyledHeading("Expense Tracker"),
                ),
              ),
              Positioned(
                  top: 15,
                  right: 10,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        setState(() {
                          AuthServices.signOut();
                        });
                      },
                      child: const Icon(Icons.logout)))
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: extendNavRail,
            elevation: 0.18,
            leading: IconButton(
              icon: Icon(extendedNavRailIcon),
              onPressed: () {
                setState(() {
                  extendNavRail = !extendNavRail;
                  extendedNavRailIcon == Icons.menu
                      ? extendedNavRailIcon = Icons.arrow_back
                      : extendedNavRailIcon = Icons.menu;
                });
              },
              color: Colors.white,
            ),
            groupAlignment: -0.8, //,-1.00 to 1.00
            indicatorColor: AppColors.highlightColor,
            // labelType: NavigationRailLabelType.selected,
            backgroundColor: AppColors.surfaceColor,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: navigationDestinations,
          ),
          Expanded(child: _pages[_selectedIndex])
        ],
      ),
    );
  }
}
// bottomNavigationBar: NavigationBar(
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   backgroundColor: AppColors.primaryAccent,
      //   indicatorColor: AppColors.primaryColor,
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[  
      //     NavigationDestination(
      //       icon: Icon(
      //         Icons.home, 
      //         color: Colors.white,
      //       ),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(
      //         Icons.pie_chart,
      //         color: Colors.white,
      //       ),
      //       label: 'Analysis',
      //     ),
      //     NavigationDestination(
      //       // enabled: false,
      //       icon: Badge(
      //         label: Text('Test'),
      //         child: Icon(
      //           Icons.settings,
      //           color: Colors.white,
      //         ),
      //       ),
      //       label: 'History',
      //     ),
      //   ],
      // ),
      // body: <Widget>[
      //   const HomeScreen(),
      //   const AnalysisScreen(),
      //   // BackendTest(),
      //   
      // 
      // 
      // tionallySizedBoxExample()
      // ][currentPageIndex],