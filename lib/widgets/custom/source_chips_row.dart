// Source document chips shown beneath an assistant response.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Wraps source names in compact neutral chips.
class SourceChipsRow extends StatelessWidget {
  const SourceChipsRow({super.key, required this.sources});
  final List<String> sources;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpacing.small,
    children: sources
        .map(
          (source) => Chip(
            label: Text(source, style: AppTextStyles.caption),
            backgroundColor: AppColors.background,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
          ),
        )
        .toList(),
  );
}
