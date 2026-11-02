// State for the patient profile and profile editor data.
// Holds the patient's profile, city choices, and request status.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/city.dart';
import '../../../data/models/patient.dart';

/// Holds profile data and profile operation status.
class ProfileState extends Equatable {
  const ProfileState({
    this.status = FeatureStatus.initial,
    this.profile,
    this.cities = const [],
    this.errorMessage,
  });
  final FeatureStatus status;
  final Patient? profile;
  final List<City> cities;
  final String? errorMessage;
  ProfileState copyWith({
    FeatureStatus? status,
    Patient? profile,
    List<City>? cities,
    String? errorMessage,
    bool clearError = false,
  }) => ProfileState(
    status: status ?? this.status,
    profile: profile ?? this.profile,
    cities: cities ?? this.cities,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [status, profile, cities, errorMessage];
}
