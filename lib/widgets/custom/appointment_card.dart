// Appointment information card with status and detail tap action.
import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';
import '../common/status_chip.dart';

/// Displays appointment details and its supplied status.
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.doctor,
    required this.specialty,
    required this.day,
    required this.date,
    required this.time,
    required this.clinic,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });
  final String doctor, specialty, day, date, time, clinic, status;
  final Color statusColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => AppCard(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(doctor, style: AppTextStyles.sectionTitle)),
            StatusChip(label: status, colour: statusColor),
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        Text(specialty, style: AppTextStyles.caption),
        Text('$day, $date · $time', style: AppTextStyles.bodySmall),
        Text(clinic, style: AppTextStyles.caption),
      ],
    ),
  );
}
