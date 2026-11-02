// Stores the selected review rating and submits review requests.
// The result contains the doctor's updated rating and review count.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/appointment_repository.dart';
import 'write_review_event.dart';
import 'write_review_state.dart';

/// Coordinates review entry and submission.
class WriteReviewBloc extends Bloc<WriteReviewEvent, WriteReviewState> {
  WriteReviewBloc(this._repository, String appointmentId)
    : super(WriteReviewState(appointmentId: appointmentId)) {
    on<ReviewRatingChanged>(
      (event, emit) =>
          emit(state.copyWith(rating: event.rating, clearError: true)),
    );
    on<ReviewSubmitted>((event, emit) async {
      if (state.rating < 1 || state.rating > 5) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: 'Choose a rating from 1 to 5.',
          ),
        );
        return;
      }
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final result = await _repository.addReview(
          appointmentId: state.appointmentId,
          rating: state.rating,
          comment: event.comment.trim().isEmpty ? null : event.comment.trim(),
        );
        emit(state.copyWith(status: FeatureStatus.success, result: result));
      } on ApiException catch (error) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: error.message,
          ),
        );
      }
    });
  }
  final AppointmentRepository _repository;
}
