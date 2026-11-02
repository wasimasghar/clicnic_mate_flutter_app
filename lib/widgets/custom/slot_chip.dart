// Selectable appointment time chip.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Slot button that uses teal fill when selected.
class SlotChip extends StatelessWidget {
  const SlotChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ChoiceChip(
    label: Text(
      label,
      style: AppTextStyles.chip.copyWith(
        color: isSelected ? AppColors.white : AppColors.textPrimary,
      ),
    ),

    selected: isSelected,
    onSelected: (_) => onTap(),
    selectedColor: AppColors.primary,
    backgroundColor: AppColors.white,
    side: const BorderSide(color: AppColors.divider),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.small,
      vertical: AppSpacing.extraSmall,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
  );
}
