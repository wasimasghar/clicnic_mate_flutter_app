// Five-star tappable rating control.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Rating row that reports values from one through five.
class RatingStarsInput extends StatelessWidget {
  const RatingStarsInput({
    super.key,
    required this.rating,
    required this.onChanged,
  });
  final int rating;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      5,
      (index) => IconButton(
        onPressed: () => onChanged(index + 1),
        icon: Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: AppColors.warning,
          size: AppSpacing.largeIconCircleSize / 2,
        ),
      ),
    ),
  );
}
