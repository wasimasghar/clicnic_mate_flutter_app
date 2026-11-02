// State for review rating selection and submission result.
// Exposes the updated doctor rating after a successful review.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/review_result.dart';

/// Holds review form state and the backend rating result.
class WriteReviewState extends Equatable {
  const WriteReviewState({
    required this.appointmentId,
    this.status = FeatureStatus.initial,
    this.rating = 0,
    this.result,
    this.errorMessage,
  });
  final String appointmentId;
  final FeatureStatus status;
  final int rating;
  final ReviewResult? result;
  final String? errorMessage;
  WriteReviewState copyWith({
    FeatureStatus? status,
    int? rating,
    ReviewResult? result,
    String? errorMessage,
    bool clearError = false,
  }) => WriteReviewState(
    appointmentId: appointmentId,
    status: status ?? this.status,
    rating: rating ?? this.rating,
    result: result ?? this.result,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [
    appointmentId,
    status,
    rating,
    result,
    errorMessage,
  ];
}
