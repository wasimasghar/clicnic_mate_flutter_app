// State for the selected doctor's public profile.
// Holds profile data or an error suitable for the existing error view.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/doctor_profile.dart';

/// Represents doctor profile loading and results.
class DoctorProfileState extends Equatable {
  const DoctorProfileState({
    this.status = FeatureStatus.initial,
    this.profile,
    this.errorMessage,
  });
  final FeatureStatus status;
  final DoctorProfile? profile;
  final String? errorMessage;
  DoctorProfileState copyWith({
    FeatureStatus? status,
    DoctorProfile? profile,
    String? errorMessage,
    bool clearError = false,
  }) => DoctorProfileState(
    status: status ?? this.status,
    profile: profile ?? this.profile,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [status, profile, errorMessage];
}
