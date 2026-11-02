// Events for the patient's appointment history.
// Tab changes and confirmed cancellation are explicit actions.

import 'package:equatable/equatable.dart';

/// Base type for appointment list actions.
sealed class MyAppointmentsEvent extends Equatable {
  const MyAppointmentsEvent();
  @override
  List<Object?> get props => [];
}

/// Loads appointments for the active tab.
class MyAppointmentsRequested extends MyAppointmentsEvent {
  const MyAppointmentsRequested();
}

/// Changes between upcoming and past appointment views.
class MyAppointmentsTabChanged extends MyAppointmentsEvent {
  const MyAppointmentsTabChanged(this.upcomingOnly);
  final bool upcomingOnly;
  @override
  List<Object?> get props => [upcomingOnly];
}

/// Cancels an appointment after the screen's confirmation dialog.
class AppointmentCancelRequested extends MyAppointmentsEvent {
  const AppointmentCancelRequested(this.appointmentId);
  final String appointmentId;
  @override
  List<Object?> get props => [appointmentId];
}
