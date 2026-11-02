// Tappable profile menu row with optional destructive styling.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Menu action with a leading icon and chevron.
class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;
  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: Icon(icon, color: color),
      title: Text(label, style: AppTextStyles.bodySmall.copyWith(color: color)),

      trailing: const Icon(Icons.chevron_right, color: AppColors.hint),
      onTap: onTap,
      minLeadingWidth: AppSpacing.large,
    );
  }
}
