// White pill search field matching the My Health reference.

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Rounded search bar with a grey search icon and hint text.
class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.hint,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.searchBarHeight,
      child: TextField(
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        style: AppTextStyles.bodySmall,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.hint,
          filled: true,
          fillColor: AppColors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.hint,
            size: AppSpacing.iconSize,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.large,
            vertical: AppSpacing.medium,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: AppSpacing.inputBorderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
