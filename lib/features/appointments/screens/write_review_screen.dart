// Patient review form with a five-star rating control.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_text_field.dart';
import '../../../widgets/common/primary_button.dart';
import '../../../widgets/custom/rating_stars_input.dart';

/// Collects a star rating and written review for a completed appointment.
class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
    this.rating = 0,
    this.onRatingChanged,
  });
  final void Function(int rating, String comment) onSubmit;
  final bool isLoading;
  final int rating;
  final ValueChanged<int>? onRatingChanged;
  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

/// Owns the current rating and review text.
class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController comment = TextEditingController();
  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(AppStrings.writeReview)),

    body: ListView(
      padding: const EdgeInsets.all(AppSpacing.extraLarge),
      children: [
        Text(AppStrings.writeReview, style: AppTextStyles.heading),
        RatingStarsInput(
          rating: widget.rating,
          onChanged: widget.onRatingChanged ?? (_) {},
        ),
        const SizedBox(height: AppSpacing.large),
        AppTextField(
          label: AppStrings.bio,
          hint: AppStrings.bioHint,
          controller: comment,
          maxLines: 5,
        ),
        const SizedBox(height: AppSpacing.xxLarge),
        PrimaryButton(
          label: AppStrings.submitReview,

          onPressed: () => widget.onSubmit(widget.rating, comment.text),
          isLoading: widget.isLoading,
        ),
      ],
    ),
  );
}
