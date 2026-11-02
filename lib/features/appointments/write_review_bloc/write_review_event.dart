// Events for rating selection and review submission.
// Review submission is tied to one appointment id.

import 'package:equatable/equatable.dart';

/// Base type for review form actions.
sealed class WriteReviewEvent extends Equatable {
  const WriteReviewEvent();
  @override
  List<Object?> get props => [];
}

/// Changes the selected star rating.
class ReviewRatingChanged extends WriteReviewEvent {
  const ReviewRatingChanged(this.rating);
  final int rating;
  @override
  List<Object?> get props => [rating];
}

/// Submits the written review comment.
class ReviewSubmitted extends WriteReviewEvent {
  const ReviewSubmitted(this.comment);
  final String comment;
  @override
  List<Object?> get props => [comment];
}
