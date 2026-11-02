// Doctor profile, clinic schedule, patient summary, and latest reviews.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_card.dart';
import '../../../widgets/common/primary_button.dart';
import '../../../widgets/common/section_header.dart';
import '../../../widgets/custom/initials_avatar.dart';
import '../../../widgets/custom/review_tile.dart';
import '../../../widgets/custom/weekly_timing_row.dart';

/// Doctor profile assembled entirely from caller supplied information.
class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.qualifications,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.fee,
    required this.about,
    required this.patientSummary,
    required this.weeklyDays,
    required this.weeklyHours,
    required this.reviewAuthors,
    required this.reviewRatings,
    required this.reviewTexts,
    required this.onBook,
  });
  final String doctorName,
      specialty,
      qualifications,
      experience,
      rating,
      about,
      patientSummary;
  final int reviewCount, fee;
  final List<String> weeklyDays,
      weeklyHours,
      reviewAuthors,
      reviewRatings,
      reviewTexts;
  final VoidCallback onBook;
  String get initials => doctorName
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0])
      .join()
      .toUpperCase();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.extraLarge,

          AppSpacing.extraLarge,
          AppSpacing.extraLarge,
          AppSpacing.xxxLarge,
        ),
        children: [
          Center(
            child: InitialsAvatar(
              initials: initials,
              size: AppSpacing.splashCircleSize / 2,
            ),
          ),
          const SizedBox(height: AppSpacing.large),
          Text(
            doctorName,
            style: AppTextStyles.heading,
            textAlign: TextAlign.center,
          ),
          Text(
            specialty,
            style: AppTextStyles.body.copyWith(color: AppColors.primary),
            textAlign: TextAlign.center,
          ),
          Text(
            qualifications,
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.medium),
          Center(
            child: Text(
              '$experience · ★ $rating ($reviewCount${AppStrings.reviewsCountSuffix}) · ${AppStrings.rupeesPrefix}$fee',

              style: AppTextStyles.bodySmall,
            ),
          ),
          const SizedBox(height: AppSpacing.xxLarge),
          const SectionHeader(title: AppStrings.about),
          AppCard(child: Text(about, style: AppTextStyles.bodySmall)),
          const SizedBox(height: AppSpacing.large),
          const SectionHeader(title: AppStrings.patientsSay),
          AppCard(child: Text(patientSummary, style: AppTextStyles.bodySmall)),
          const SizedBox(height: AppSpacing.large),
          const SectionHeader(title: AppStrings.weeklyTimings),
          AppCard(
            child: Column(
              children: List.generate(
                weeklyDays.length,

                (index) => WeeklyTimingRow(
                  day: weeklyDays[index],
                  time: weeklyHours[index],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.large),
          const SectionHeader(title: AppStrings.latestReviews),

          if (reviewTexts.isEmpty)
            Text(AppStrings.noReviewsYet, style: AppTextStyles.caption)
          else
            ...List.generate(
              reviewTexts.length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.medium),
                child: ReviewTile(
                  author: reviewAuthors[index],
                  rating: reviewRatings[index],
                  review: reviewTexts[index],
                ),
              ),
            ),
        ],
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        child: PrimaryButton(
          label: AppStrings.bookAppointment,
          onPressed: onBook,
        ),
      ),
    ),
  );
}
