// Compact progress indicator shown while the assistant is working.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Spinner and caller supplied status message.
class AssistantStatusRow extends StatelessWidget {
  const AssistantStatusRow({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      const SizedBox(
        width: AppSpacing.large,
        height: AppSpacing.large,
        child: CircularProgressIndicator(
          strokeWidth: AppSpacing.inputBorderWidth,

          color: AppColors.primary,
        ),
      ),
      const SizedBox(width: AppSpacing.small),
      Text(message, style: AppTextStyles.caption),
    ],
  );
}
