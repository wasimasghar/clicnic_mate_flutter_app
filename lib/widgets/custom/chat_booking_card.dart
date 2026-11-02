// Booking preview with actions or a completed booked state.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';
import '../common/secondary_button.dart';

/// Booking summary with confirm, change-time, and booked modes.
class ChatBookingCard extends StatelessWidget {
  const ChatBookingCard({
    super.key,
    required this.summary,
    required this.isBooked,
    required this.onConfirm,
    required this.onChangeTime,
    this.statusText = AppStrings.statusBooked,
  });
  final String summary;
  final bool isBooked;
  final VoidCallback onConfirm, onChangeTime;
  final String statusText;
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        if (isBooked)
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: AppSpacing.small),
              Text(
                statusText,
                style: AppTextStyles.sectionTitle.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          )
        else
          Text(summary, style: AppTextStyles.bodySmall),
        if (!isBooked) ...[
          const SizedBox(height: AppSpacing.small),

          SecondaryButton(label: AppStrings.confirm, onPressed: onConfirm),
          TextButton(
            onPressed: onChangeTime,
            child: const Text(AppStrings.changeTime),
          ),
        ],
      ],
    ),
  );
}
