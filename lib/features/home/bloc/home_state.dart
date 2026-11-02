// State for home dashboard directory and appointment content.
// Exposes specialty names and whether an upcoming appointment exists.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/specialty.dart';
import '../../../data/models/appointment.dart';

/// Holds dashboard load status and its backend data.
class HomeState extends Equatable {
  const HomeState({
    this.status = FeatureStatus.initial,
    this.specialties = const [],
    this.upcomingAppointment,
    this.errorMessage,
  });
  final FeatureStatus status;
  final List<Specialty> specialties;
  final Appointment? upcomingAppointment;
  final String? errorMessage;
  HomeState copyWith({
    FeatureStatus? status,
    List<Specialty>? specialties,
    Appointment? upcomingAppointment,
    String? errorMessage,
    bool clearAppointment = false,
    bool clearError = false,
  }) => HomeState(
    status: status ?? this.status,
    specialties: specialties ?? this.specialties,
    upcomingAppointment: clearAppointment
        ? null
        : upcomingAppointment ?? this.upcomingAppointment,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [
    status,
    specialties,
    upcomingAppointment,
    errorMessage,
  ];
}
