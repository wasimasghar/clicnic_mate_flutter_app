// Suggested starter prompts for an empty assistant conversation.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Tappable prompt chips that send their text to the caller.
class SuggestionChipsRow extends StatelessWidget {
  const SuggestionChipsRow({
    super.key,
    required this.suggestions,
    required this.onSelected,
  });
  final List<String> suggestions;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSpacing.small,
    runSpacing: AppSpacing.small,
    children: suggestions
        .map(
          (suggestion) => ActionChip(
            label: Text(suggestion, style: AppTextStyles.caption),
            backgroundColor: AppColors.white,
            side: const BorderSide(color: AppColors.divider),
            onPressed: () => onSelected(suggestion),
          ),
        )
        .toList(),
  );
}
