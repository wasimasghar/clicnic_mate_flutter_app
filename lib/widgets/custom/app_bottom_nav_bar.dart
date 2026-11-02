// Five destination bottom navigation for the signed-in app shell.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Bottom navigation that reports the selected destination index.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) => BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: onSelected,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondary,
    selectedLabelStyle: AppTextStyles.caption,
    unselectedLabelStyle: AppTextStyles.caption,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),

        activeIcon: Icon(Icons.home),
        label: AppStrings.homeTab,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: AppStrings.doctorsTab,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_outline),
        label: AppStrings.assistantTab,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month_outlined),

        label: AppStrings.appointmentsTab,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),

        label: AppStrings.profileTab,
      ),
    ],
  );
}
