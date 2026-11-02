// Circular doctor avatar that displays initials when no photo is supplied.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Shows initials in a light teal circle.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.initials,
    this.size = AppSpacing.avatarLargeSize,
  });
  final String initials;
  final double size;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: AppColors.primaryLight,

      shape: BoxShape.circle,
    ),
    child: Text(
      initials,
      style: AppTextStyles.sectionTitle.copyWith(color: AppColors.primary),
    ),
  );
}
