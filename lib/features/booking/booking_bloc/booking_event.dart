// Events for quote retrieval and appointment confirmation.
// Booking is submitted only after a quote has been requested.

import 'package:equatable/equatable.dart';

/// Base type for booking actions.
sealed class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}

/// Fetches the current quote for a selected slot.
class BookingQuoteRequested extends BookingEvent {
  const BookingQuoteRequested(this.slotId);
  final String slotId;
  @override
  List<Object?> get props => [slotId];
}

/// Confirms the currently quoted appointment with an optional reason.
class BookingConfirmed extends BookingEvent {
  const BookingConfirmed({this.reason});
  final String? reason;
  @override
  List<Object?> get props => [reason];
}
