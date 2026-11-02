// State for the active appointment list and selected tab.
// Includes status and any readable repository error.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/appointment.dart';

/// Holds appointments and the current upcoming or past filter.
class MyAppointmentsState extends Equatable {
  const MyAppointmentsState({
    this.status = FeatureStatus.initial,
    this.appointments = const [],
    this.upcomingOnly = true,
    this.errorMessage,
  });
  final FeatureStatus status;
  final List<Appointment> appointments;
  final bool upcomingOnly;
  final String? errorMessage;
  MyAppointmentsState copyWith({
    FeatureStatus? status,
    List<Appointment>? appointments,
    bool? upcomingOnly,
    String? errorMessage,
    bool clearError = false,
  }) => MyAppointmentsState(
    status: status ?? this.status,
    appointments: appointments ?? this.appointments,
    upcomingOnly: upcomingOnly ?? this.upcomingOnly,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [status, appointments, upcomingOnly, errorMessage];
}
