// Retrieves one doctor's full profile using the doctor repository.
// The UI observes state and never calls the repository directly.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/doctor_repository.dart';
import 'doctor_profile_event.dart';
import 'doctor_profile_state.dart';

/// Loads profile data after a doctor is selected.
class DoctorProfileBloc extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  DoctorProfileBloc(this._repository) : super(const DoctorProfileState()) {
    on<DoctorProfileRequested>((e, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final profile = await _repository.getDoctorProfile(e.doctorId);
        emit(state.copyWith(status: FeatureStatus.success, profile: profile));
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
  final DoctorRepository _repository;
}
