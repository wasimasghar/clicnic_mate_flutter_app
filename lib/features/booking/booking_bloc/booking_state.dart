// State for quote display and booking submission.
// Keeps selected slot, quote, appointment, and actionable errors.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/appointment.dart';
import '../../../data/models/booking_quote.dart';

/// Holds quote and appointment confirmation state.
class BookingState extends Equatable {
  const BookingState({
    this.status = FeatureStatus.initial,
    this.quote,
    this.appointment,
    this.errorMessage,
    this.slotTaken = false,
  });
  final FeatureStatus status;
  final BookingQuote? quote;
  final Appointment? appointment;
  final String? errorMessage;
  final bool slotTaken;
  BookingState copyWith({
    FeatureStatus? status,
    BookingQuote? quote,
    Appointment? appointment,
    String? errorMessage,
    bool? slotTaken,
    bool clearError = false,
  }) => BookingState(
    status: status ?? this.status,
    quote: quote ?? this.quote,
    appointment: appointment ?? this.appointment,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    slotTaken: slotTaken ?? this.slotTaken,
  );
  @override
  List<Object?> get props => [
    status,
    quote,
    appointment,
    errorMessage,
    slotTaken,
  ];
}
