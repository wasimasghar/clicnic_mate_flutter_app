// Events for loading public doctor profile details.
// The doctor id identifies the requested backend resource.

import 'package:equatable/equatable.dart';

/// Base type for doctor profile actions.
sealed class DoctorProfileEvent extends Equatable {
  const DoctorProfileEvent();
  @override
  List<Object?> get props => [];
}

/// Requests profile, schedule, and latest review details for a doctor.
class DoctorProfileRequested extends DoctorProfileEvent {
  const DoctorProfileRequested(this.doctorId);
  final String doctorId;
  @override
  List<Object?> get props => [doctorId];
}
