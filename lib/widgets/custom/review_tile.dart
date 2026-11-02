// Single patient review row for a doctor profile.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';

/// Review presentation with author, rating, and text supplied by its screen.
class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.author,
    required this.rating,
    required this.review,
  });

  final String author;
  final String rating;
  final String review;
  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.all(AppSpacing.large),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(author, style: AppTextStyles.sectionTitle)),
            const Icon(
              Icons.star,
              color: AppColors.warning,
              size: AppSpacing.smallIconSize,
            ),
            const SizedBox(width: AppSpacing.extraSmall),
            Text(rating, style: AppTextStyles.caption),
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          review,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
