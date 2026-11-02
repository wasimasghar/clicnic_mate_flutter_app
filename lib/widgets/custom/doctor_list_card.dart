// Reusable doctor result card with clinic, rating, fee and next slot details.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';
import 'initials_avatar.dart';

/// Doctor summary that opens the supplied profile callback.
class DoctorListCard extends StatelessWidget {
  const DoctorListCard({
    super.key,
    required this.initials,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.fee,
    required this.clinic,
    required this.area,
    required this.nextTime,
    required this.onTap,
  });
  final String initials, name, specialty, rating, clinic, area, nextTime;
  final int fee;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => AppCard(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InitialsAvatar(
          initials: initials,
          size: AppSpacing.avatarLargeSize / 1.4,
        ),
        const SizedBox(width: AppSpacing.medium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(name, style: AppTextStyles.sectionTitle),
              const SizedBox(height: AppSpacing.extraSmall),
              Text(specialty, style: AppTextStyles.caption),
              Text('$clinic · $area', style: AppTextStyles.caption),

              const SizedBox(height: AppSpacing.small),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.warning,
                    size: AppSpacing.smallIconSize,
                  ),
                  Text(' $rating', style: AppTextStyles.caption),
                  const Spacer(),
                  Text(
                    '${AppStrings.rupeesPrefix}$fee',
                    style: AppTextStyles.sectionTitle,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.small),
              Text(
                '${AppStrings.nextPrefix}$nextTime',
                style: AppTextStyles.chip.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
