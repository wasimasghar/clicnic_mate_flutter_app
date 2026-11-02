// Persistent five-tab shell shown after successful sign in.
import 'package:flutter/material.dart';
import '../../../widgets/custom/app_bottom_nav_bar.dart';

/// Keeps each supplied tab screen alive inside an indexed stack.
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({
    super.key,
    required this.homeScreen,
    required this.doctorsScreen,
    required this.assistantScreen,
    required this.appointmentsScreen,
    required this.profileScreen,
    this.initialIndex = 0,
  });
  final Widget homeScreen,
      doctorsScreen,
      assistantScreen,
      appointmentsScreen,
      profileScreen;
  final int initialIndex;
  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

/// Tracks the currently selected bottom navigation tab.
class _MainShellScreenState extends State<MainShellScreen> {
  late int selectedIndex = widget.initialIndex;
  @override
  Widget build(BuildContext context) {
    final screens = [
      widget.homeScreen,
      widget.doctorsScreen,
      widget.assistantScreen,
      widget.appointmentsScreen,
      widget.profileScreen,
    ];
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: selectedIndex,
        onSelected: (index) => setState(() => selectedIndex = index),
      ),
    );
  }
}
