// Events for availability loading and slot selection.
// Each event represents a single action on the booking calendar.

import 'package:equatable/equatable.dart';

/// Base type for slot picker actions.
sealed class SlotPickerEvent extends Equatable {
  const SlotPickerEvent();
  @override
  List<Object?> get props => [];
}

/// Loads slot availability for a doctor and date range.
class SlotsRequested extends SlotPickerEvent {
  const SlotsRequested(this.doctorId, {this.dateFrom, this.timeOfDay});
  final String doctorId;
  final String? dateFrom, timeOfDay;
  @override
  List<Object?> get props => [doctorId, dateFrom, timeOfDay];
}

/// Selects an available clinic date.
class SlotDaySelected extends SlotPickerEvent {
  const SlotDaySelected(this.date);
  final String date;
  @override
  List<Object?> get props => [date];
}

/// Selects a specific backend slot id.
class SlotSelected extends SlotPickerEvent {
  const SlotSelected(this.slotId);
  final String slotId;
  @override
  List<Object?> get props => [slotId];
}
