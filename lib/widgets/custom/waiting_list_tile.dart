// Waiting-list entry with offered slot actions when available.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';
import '../common/primary_button.dart';
import '../common/status_chip.dart';

/// Waiting request and optional slot offer details.
class WaitingListTile extends StatelessWidget {
  const WaitingListTile({
    super.key,
    required this.doctorName,
    required this.preferredDate,
    required this.isSlotOffered,
    required this.offeredTime,
    required this.expiryTime,
    required this.onBook,
    required this.onLeave,
  });
  final String doctorName, preferredDate, offeredTime, expiryTime;
  final bool isSlotOffered;
  final VoidCallback onBook, onLeave;
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Expanded(
              child: Text(doctorName, style: AppTextStyles.sectionTitle),
            ),
            StatusChip(
              label: isSlotOffered
                  ? AppStrings.slotOffered
                  : AppStrings.waiting,

              colour: isSlotOffered ? AppColors.primary : AppColors.warning,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        Text(preferredDate, style: AppTextStyles.caption),
        if (isSlotOffered) ...[
          Text(offeredTime, style: AppTextStyles.bodySmall),
          Text(expiryTime, style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.small),
          PrimaryButton(label: AppStrings.bookThisSlot, onPressed: onBook),
        ],
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onLeave,
            child: const Text(AppStrings.leave),
          ),
        ),
      ],
    ),
  );
}
