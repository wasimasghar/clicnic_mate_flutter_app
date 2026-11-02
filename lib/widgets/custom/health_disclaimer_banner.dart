// Light warning banner clarifying the assistant's health information scope.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Shows the fixed general-information disclaimer.
class HealthDisclaimerBanner extends StatelessWidget {
  const HealthDisclaimerBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(AppSpacing.medium),
    decoration: BoxDecoration(
      color: AppColors.warning.withValues(alpha: 0.12),

      borderRadius: BorderRadius.circular(AppRadius.medium),
    ),
    child: Text(
      AppStrings.generalHealthDisclaimer,

      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
    ),
  );
}
