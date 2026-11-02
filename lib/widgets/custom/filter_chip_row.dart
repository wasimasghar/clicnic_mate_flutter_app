// Horizontally scrolling doctor search filters.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Filter chips supplied as labels with selected state and callback.
class FilterChipRow extends StatelessWidget {
  const FilterChipRow({
    super.key,
    required this.labels,
    required this.selectedLabels,
    required this.onSelected,
  });
  final List<String> labels;
  final List<String> selectedLabels;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: AppSpacing.buttonHeight,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: labels.length,
      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.small),

      itemBuilder: (context, index) {
        final label = labels[index];
        final selected = selectedLabels.contains(label);
        return FilterChip(
          label: Text(
            label,
            style: AppTextStyles.chip.copyWith(
              color: selected ? AppColors.white : AppColors.textPrimary,
            ),
          ),

          selected: selected,
          onSelected: (_) => onSelected(label),
          selectedColor: AppColors.primary,
          backgroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.divider),
        );
      },
    ),
  );
}
