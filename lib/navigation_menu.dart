import 'package:expense_tracker_2/screens/analysis/analysis_screen.dart';
import 'package:expense_tracker_2/screens/home/home_screen.dart';
import 'package:expense_tracker_2/services/auth_services.dart';
import 'package:expense_tracker_2/shared/styled_text.dart';
import 'package:expense_tracker_2/theme.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          color: AppColors.primaryColor,
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: StyledHeading("Expense Tracker"),
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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: AppColors.primaryAccent,
        indicatorColor: AppColors.primaryColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
                          Icons.pie_chart,
                          color: Colors.white,
                        ),
            label: 'Analysis',
          ),
          NavigationDestination(
            enabled: false,
            icon: Badge(
              label: Text('unavailable'),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const HomeScreen(),
        AnalysisScreen(),
        const StyledHeading(
          "Third screen is coming soon!",
        )
      ][currentPageIndex],
    );
  }
}
