// State for a selected reschedule quote and saved appointment.
// Stores both ids needed by the confirmation request.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/appointment.dart';
import '../../../data/models/booking_quote.dart';

/// Holds rescheduling status, quote, and updated appointment.
class RescheduleState extends Equatable {
  const RescheduleState({
    this.status = FeatureStatus.initial,
    this.appointmentId,
    this.newSlotId,
    this.quote,
    this.appointment,
    this.errorMessage,
  });
  final FeatureStatus status;
  final String? appointmentId, newSlotId, errorMessage;
  final BookingQuote? quote;
  final Appointment? appointment;
  RescheduleState copyWith({
    FeatureStatus? status,
    String? appointmentId,
    String? newSlotId,
    BookingQuote? quote,
    Appointment? appointment,
    String? errorMessage,
    bool clearError = false,
    bool clearQuote = false,
  }) => RescheduleState(
    status: status ?? this.status,
    appointmentId: appointmentId ?? this.appointmentId,
    newSlotId: newSlotId ?? this.newSlotId,
    quote: clearQuote ? null : quote ?? this.quote,
    appointment: appointment ?? this.appointment,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [
    status,
    appointmentId,
    newSlotId,
    quote,
    appointment,
    errorMessage,
  ];
}
