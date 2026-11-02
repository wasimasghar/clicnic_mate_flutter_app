// Teal pill button used for main actions such as booking an appointment.

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Full-width primary action button with an optional leading icon and loading state.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.primaryDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
        child: isLoading
            ? const ButtonLoadingSpinner()
            : ButtonLabel(label: label, icon: icon),
      ),
    );
  }
}

/// White spinner shown inside PrimaryButton while a request is in progress.
class ButtonLoadingSpinner extends StatelessWidget {
  const ButtonLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: AppSpacing.iconSize,
      height: AppSpacing.iconSize,
      child: CircularProgressIndicator(
        strokeWidth: AppSpacing.spinnerStrokeWidth,
        color: AppColors.white,
      ),
    );
  }
}

/// Label row for PrimaryButton, with an optional outlined icon.
class ButtonLabel extends StatelessWidget {
  const ButtonLabel({super.key, required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return Text(label, style: AppTextStyles.primaryButton);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: AppSpacing.smallIconSize, color: AppColors.white),
        const SizedBox(width: AppSpacing.small),
        Text(label, style: AppTextStyles.primaryButton),
      ],
    );
  }
}
