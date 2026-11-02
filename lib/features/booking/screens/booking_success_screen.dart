// Confirmation screen shown when an appointment is booked.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/primary_button.dart';
import '../../../widgets/common/secondary_button.dart';

/// Booking result with appointment details and next actions.
class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({
    super.key,
    required this.summaryLines,
    required this.onViewAppointments,
    required this.onBackHome,
  });
  final List<String> summaryLines;
  final VoidCallback onViewAppointments, onBackHome;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppSpacing.splashCircleSize / 2,
              height: AppSpacing.splashCircleSize / 2,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,

                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: AppSpacing.avatarLargeSize,
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            Text(
              AppStrings.appointmentBooked,
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.large),
            ...summaryLines.map(
              (line) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.extraSmall,
                ),

                child: Text(
                  line,
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxLarge),
            PrimaryButton(
              label: AppStrings.viewMyAppointments,

              onPressed: onViewAppointments,
            ),
            const SizedBox(height: AppSpacing.medium),
            SecondaryButton(
              label: AppStrings.backToHome,
              onPressed: onBackHome,
            ),
          ],
        ),
      ),
    ),
  );
}
