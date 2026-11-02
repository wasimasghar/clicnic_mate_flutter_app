// Horizontal day selection strip for choosing an appointment date.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Selectable day and date tile.
class DaySelector extends StatelessWidget {
  const DaySelector({
    super.key,
    required this.days,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> days;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: AppSpacing.daySelectorHeight,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: days.length,
      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.small),

      itemBuilder: (context, index) {
        final selected = index == selectedIndex;
        return GestureDetector(
          onTap: () => onSelected(index),

          child: Container(
            width: AppSpacing.daySelectorWidth,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.white,

              borderRadius: BorderRadius.circular(AppRadius.medium),
            ),
            alignment: Alignment.center,
            child: Text(
              days[index],
              style: AppTextStyles.caption.copyWith(
                color: selected ? AppColors.white : AppColors.textPrimary,
              ),

              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    ),
  );
}
