import 'package:expense_tracker_2/navigation/widgets/share_with_friends.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_2/Theme/theme.dart';
import 'package:expense_tracker_2/services/firebase_services/auth_services.dart';
import 'package:expense_tracker_2/widgets/styled_widgets/styled_text.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: const StyledHeading("Expense Tracker"),
      actions: [
        const ShareWithFriends(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            AuthServices.signOut(); // Sign out the user
          },
          child: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0); // Set the app bar height
}
