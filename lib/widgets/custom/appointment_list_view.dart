// Filters and renders one appointment tab with its data states.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_spacing.dart';
import '../common/empty_state_view.dart';
import '../common/error_state_view.dart';
import '../common/loading_view.dart';
import 'appointment_card.dart';

/// Renders upcoming or past appointment rows.
class AppointmentListView extends StatelessWidget {
  const AppointmentListView({
    super.key,
    required this.isUpcomingTab,
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
  });
  final bool isUpcomingTab, isLoading;
  final String? errorMessage;
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

  @override
  Widget build(BuildContext context) {
    final indexes = List.generate(
      doctorNames.length,
      (index) => index,
    ).where((index) => isUpcoming[index] == isUpcomingTab).toList();
    if (isLoading) return const LoadingView();
    if (errorMessage != null) {
      return ErrorStateView(message: errorMessage!, onRetry: onRetry);
    }
    if (indexes.isEmpty) {
      return EmptyStateView(
        icon: Icons.calendar_month_outlined,

        title: isUpcomingTab ? AppStrings.upcoming : AppStrings.past,
        message: AppStrings.emptyStateMessage,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.extraLarge),

      itemCount: indexes.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.medium),

      itemBuilder: (_, row) {
        final index = indexes[row];
        return AppointmentCard(
          doctor: doctorNames[index],

          specialty: specialties[index],
          day: days[index],
          date: dates[index],
          time: times[index],
          clinic: clinics[index],
          status: statuses[index],
          statusColor: statusColors[index],
          onTap: () => onAppointmentTap(index),
        );
      },
    );
  }
}
