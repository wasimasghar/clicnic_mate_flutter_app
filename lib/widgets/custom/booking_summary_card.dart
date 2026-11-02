// Appointment details grouped into a reusable confirmation card.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';

/// Summary of doctor, clinic, appointment time, and fee.
class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({
    super.key,
    required this.doctor,
    required this.specialty,
    required this.clinic,
    required this.address,
    required this.day,
    required this.date,
    required this.time,
    required this.fee,
  });
  final String doctor, specialty, clinic, address, day, date, time;
  final int fee;
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      children: [
        SummaryLine(label: AppStrings.summaryDoctor, value: doctor),
        SummaryLine(label: AppStrings.summarySpecialty, value: specialty),
        SummaryLine(label: AppStrings.summaryClinic, value: clinic),
        SummaryLine(label: AppStrings.summaryAddress, value: address),
        SummaryLine(label: AppStrings.summaryDay, value: day),
        SummaryLine(label: AppStrings.summaryDate, value: date),
        SummaryLine(label: AppStrings.summaryTime, value: time),
        SummaryLine(
          label: AppStrings.summaryFee,
          value: '${AppStrings.rupeesPrefix}$fee',
        ),
      ],
    ),
  );
}

/// Label and value pair inside a booking summary.
class SummaryLine extends StatelessWidget {
  const SummaryLine({super.key, required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label, style: AppTextStyles.caption)),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}
