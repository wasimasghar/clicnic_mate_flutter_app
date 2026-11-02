// Notification bell with the ClinicMate unread marker.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Bell action with a small pink notification dot.
class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onTap,
    icon: Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(
          Icons.notifications_none,
          color: AppColors.textPrimary,
          size: AppSpacing.iconSize,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: AppSpacing.small,
            height: AppSpacing.small,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
  );
}
