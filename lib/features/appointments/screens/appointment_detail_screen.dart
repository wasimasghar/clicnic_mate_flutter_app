// Full appointment details and status-specific actions.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/primary_button.dart';
import '../../../widgets/common/secondary_button.dart';
import '../../../widgets/custom/appointment_card.dart';
import '../../../widgets/custom/confirm_dialog.dart';

/// Appointment detail page with actions based on completion state.
class AppointmentDetailScreen extends StatelessWidget {
  const AppointmentDetailScreen({
    super.key,
    required this.doctor,
    required this.specialty,
    required this.day,
    required this.date,
    required this.time,
    required this.clinic,
    required this.address,
    required this.status,
    required this.statusColor,
    required this.isCompleted,
    required this.onReschedule,
    required this.onCancel,
    required this.onWriteReview,
  });
  final String doctor, specialty, day, date, time, clinic, address, status;
  final Color statusColor;
  final bool isCompleted;
  final VoidCallback onReschedule, onCancel, onWriteReview;
  Future<void> _confirmCancel(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,

      builder: (_) => const ConfirmDialog(),
    );
    if (confirmed == true) onCancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.appointmentsTab)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppointmentCard(
              doctor: doctor,
              specialty: specialty,
              day: day,
              date: date,
              time: time,
              clinic: clinic,
              status: status,
              statusColor: statusColor,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.large),
            Text(
              '${AppStrings.summaryAddress}: $address',
              style: AppTextStyles.bodySmall,
            ),
            const Spacer(),
            if (isCompleted)
              PrimaryButton(
                label: AppStrings.writeReview,
                onPressed: onWriteReview,
              )
            else
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: AppStrings.reschedule,
                      onPressed: onReschedule,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: PrimaryButton(
                      label: AppStrings.cancel,
                      onPressed: () => _confirmCancel(context),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
