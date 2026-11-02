// Error placeholder with a retry action for failed loads.

import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'icon_circle.dart';
import 'primary_button.dart';

/// Centred error message and a retry button.
class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconCircle(
              icon: Icons.error_outline,
              size: AppSpacing.largeIconCircleSize,
            ),
            const SizedBox(height: AppSpacing.large),
            Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.extraLarge),
            PrimaryButton(label: AppStrings.retry, onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
