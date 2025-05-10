import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/providers/page_index_provider.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationRailWidget extends ConsumerStatefulWidget {
  const NavigationRailWidget({
    super.key,
    required this.selectedIndex,
    required this.pages,
  });
  final int selectedIndex;
  final List<Map<String, dynamic>> pages;

  @override
  ConsumerState<NavigationRailWidget> createState() => _NavigationRailState();
}

class _NavigationRailState extends ConsumerState<NavigationRailWidget> {
  bool extendNavRail = false;
  IconData extendedNavRailIcon = Icons.menu;
  
  List<NavigationRailDestination> get navigationDestinations {
    return widget.pages.map((element) {
      return NavigationRailDestination(
        icon: element['icon'],
        label: StyledText(text: (element['label'])),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
          labelType: extendNavRail
              ? NavigationRailLabelType.none
              : NavigationRailLabelType.selected,
          backgroundColor: AppColors.surfaceColor,
          selectedIndex: widget.selectedIndex,
          onDestinationSelected: (int index) {
            ref.read(pageIndexProvider.notifier).state = index;
          },
          destinations: navigationDestinations,
        ),
        Expanded(child: widget.pages[widget.selectedIndex]['widget'])
      ],
    );
  }
}
