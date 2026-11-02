// Appointment confirmation review and optional visit reason.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_text_field.dart';
import '../../../widgets/common/primary_button.dart';
import '../../../widgets/custom/booking_summary_card.dart';

/// Confirmation screen for a selected doctor and appointment slot.
class BookingConfirmScreen extends StatelessWidget {
  const BookingConfirmScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.clinicName,
    required this.address,
    required this.day,
    required this.date,
    required this.time,
    required this.fee,
    required this.onConfirm,
    this.reasonController,
    this.isLoading = false,
  });
  final String doctorName, specialty, clinicName, address, day, date, time;
  final int fee;
  final VoidCallback onConfirm;
  final TextEditingController? reasonController;
  final bool isLoading;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        children: [
          Text(AppStrings.confirmBookingTitle, style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.large),
          BookingSummaryCard(
            doctor: doctorName,
            specialty: specialty,
            clinic: clinicName,
            address: address,
            day: day,
            date: date,
            time: time,
            fee: fee,
          ),
          const SizedBox(height: AppSpacing.large),

          AppTextField(
            label: AppStrings.reasonForVisit,
            hint: AppStrings.reasonForVisitHint,
            controller: reasonController ?? TextEditingController(),
            maxLines: 3,
          ),
          const SizedBox(height: AppSpacing.large),
          Text(AppStrings.payFeeAtClinic, style: AppTextStyles.bodySmall),
          const SizedBox(height: AppSpacing.xxLarge),
          PrimaryButton(
            label: AppStrings.confirmBooking,
            onPressed: onConfirm,
            isLoading: isLoading,
          ),
        ],
      ),
    ),
  );
}
