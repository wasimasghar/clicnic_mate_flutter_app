// Loads patient data, submits only changed profile values, and signs out.
// Session sign-out is delegated to the shared SessionBloc.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/doctor_repository.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/models/patient.dart';
import '../../auth/session_bloc/session_bloc.dart';
import '../../auth/session_bloc/session_event.dart';
import 'profile_event.dart';
import 'profile_state.dart';

/// Coordinates patient profile loading, editing, and sign-out.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profiles, this._doctors, this._sessionBloc)
    : super(const ProfileState()) {
    on<ProfileRequested>((event, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final values = await Future.wait<dynamic>([
          _profiles.getMyProfile(),
          _doctors.getCities(),
        ]);
        emit(
          state.copyWith(
            status: FeatureStatus.success,
            profile: values[0],
            cities: values[1],
          ),
        );
      } on ApiException catch (error) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: error.message,
          ),
        );
      }
    });
    on<ProfileUpdated>((event, emit) async {
      final current = state.profile;
      if (current == null) return;
      final updated = _updateChangedFields(current, event);
      if (updated.isEmpty) {
        emit(state.copyWith(status: FeatureStatus.success));
        return;
      }
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        final profile = await _profiles.updateProfile(
          fullName: updated['full_name'],
          email: updated['email'],
          city: updated['city'],
          gender: updated['gender'],
          dateOfBirth: updated['date_of_birth'],
        );
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
    on<ProfileSignOutPressed>((event, emit) async {
      _sessionBloc.add(const SessionSignedOut());
      emit(state.copyWith(status: FeatureStatus.success));
    });
  }
  final ProfileRepository _profiles;
  final DoctorRepository _doctors;
  final SessionBloc _sessionBloc;

  Map<String, String> _updateChangedFields(
    Patient current,
    ProfileUpdated event,
  ) {
    final changed = <String, String>{};
    if (event.fullName != null && event.fullName != current.fullName) {
      changed['full_name'] = event.fullName!;
    }
    if (event.email != null && event.email != current.email) {
      changed['email'] = event.email!;
    }
    if (event.city != null && event.city != current.city) {
      changed['city'] = event.city!;
    }
    if (event.gender != null &&
        event.gender!.trim().toLowerCase() !=
            current.gender?.trim().toLowerCase()) {
      changed['gender'] = event.gender!.trim().toLowerCase();
    }
    if (event.dateOfBirth != null && event.dateOfBirth != current.dateOfBirth) {
      changed['date_of_birth'] = event.dateOfBirth!;
    }
    return changed;
  }
}
