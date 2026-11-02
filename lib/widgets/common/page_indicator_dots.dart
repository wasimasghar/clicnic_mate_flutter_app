// Pill-shaped page dots used on splash and onboarding.

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Row of dots. The selected page is a wider teal pill.
class PageIndicatorDots extends StatelessWidget {
  const PageIndicatorDots({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < count; index++)
          IndicatorDot(isActive: index == currentIndex),
      ],
    );
  }
}

/// A single page indicator, either a grey circle or a teal pill.
class IndicatorDot extends StatelessWidget {
  const IndicatorDot({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.extraSmall),
      height: AppSpacing.indicatorDotSize,
      width: isActive
          ? AppSpacing.indicatorActiveWidth
          : AppSpacing.indicatorDotSize,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.divider,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
    );
  }
}
