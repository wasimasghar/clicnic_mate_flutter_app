// One weekday and its clinic opening hours.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Displays a weekday beside a timing label.
class WeeklyTimingRow extends StatelessWidget {
  const WeeklyTimingRow({super.key, required this.day, required this.time});
  final String day;
  final String time;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),

    child: Row(
      children: [
        Expanded(child: Text(day, style: AppTextStyles.bodySmall)),
        Text(
          time,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
