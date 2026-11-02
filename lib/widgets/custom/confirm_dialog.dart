// Confirmation dialog for destructive appointment actions.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_text_styles.dart';

/// Shows a cancel confirmation and returns the user's choice.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text(AppStrings.confirmCancelTitle),

    content: const Text(AppStrings.confirmCancelMessage),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text(AppStrings.noKeep),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: Text(
          AppStrings.yesCancel,
          style: AppTextStyles.body.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    ],
  );
}
