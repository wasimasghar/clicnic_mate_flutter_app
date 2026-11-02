// Specialty selection tile for the home screen.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';
import '../common/icon_circle.dart';

/// Tappable specialty icon and label.
class SpecialtyTile extends StatelessWidget {
  const SpecialtyTile({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => AppCard(
    onTap: onTap,
    padding: const EdgeInsets.all(AppSpacing.medium),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        IconCircle(icon: icon, size: AppSpacing.iconCircleSize),
        const SizedBox(height: AppSpacing.small),
        Text(
          name,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),

          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
