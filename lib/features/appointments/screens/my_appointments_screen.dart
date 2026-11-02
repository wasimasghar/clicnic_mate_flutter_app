// Upcoming and past appointment lists with empty, loading, and error states.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/custom/appointment_list_view.dart';

/// Appointment history with upcoming and past tabs.
class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({
    super.key,
    required this.doctorNames,
    required this.specialties,
    required this.days,
    required this.dates,
    required this.times,
    required this.clinics,
    required this.statuses,
    required this.statusColors,
    required this.isUpcoming,
    required this.onAppointmentTap,
    required this.onRetry,
    this.isLoading = false,
    this.errorMessage,
    this.onTabChanged,
  });
  final List<String> doctorNames,
      specialties,
      days,
      dates,
      times,
      clinics,
      statuses;
  final List<Color> statusColors;
  final List<bool> isUpcoming;
  final ValueChanged<int> onAppointmentTap;
  final VoidCallback onRetry;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<bool>? onTabChanged;
  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

/// Selects upcoming or past appointment entries.
class _MyAppointmentsScreenState extends State<MyAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(
    length: 2,
    vsync: this,
  );
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TabBar(
        controller: tabController,
        onTap: (index) => widget.onTabChanged?.call(index == 0),
        labelColor: AppColors.primary,
        tabs: const [
          Tab(text: AppStrings.upcoming),
          Tab(text: AppStrings.past),
        ],
      ),
      Expanded(
        child: TabBarView(
          controller: tabController,
          children: [true, false]
              .map(
                (upcoming) => AppointmentListView(
                  isUpcomingTab: upcoming,
                  doctorNames: widget.doctorNames,
                  specialties: widget.specialties,
                  days: widget.days,
                  dates: widget.dates,
                  times: widget.times,
                  clinics: widget.clinics,
                  statuses: widget.statuses,
                  statusColors: widget.statusColors,
                  isUpcoming: widget.isUpcoming,
                  onAppointmentTap: widget.onAppointmentTap,
                  onRetry: widget.onRetry,
                  isLoading: widget.isLoading,
                  errorMessage: widget.errorMessage,
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}
