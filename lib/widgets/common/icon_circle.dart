// Teal outlined icon sitting in a light-teal circle, as used on metric tiles.

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Circular icon badge used next to metrics, empty states, and list rows.
class IconCircle extends StatelessWidget {
  const IconCircle({super.key, required this.icon, required this.size});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.primary, size: AppSpacing.iconSize),
    );
  }
}
