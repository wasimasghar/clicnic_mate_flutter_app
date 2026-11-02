// Events for quoting and confirming an appointment reschedule.
// A new slot is quoted before the reschedule request is sent.

import 'package:equatable/equatable.dart';

/// Base type for reschedule actions.
sealed class RescheduleEvent extends Equatable {
  const RescheduleEvent();
  @override
  List<Object?> get props => [];
}

/// Selects a replacement slot and fetches its quote.
class RescheduleSlotChosen extends RescheduleEvent {
  const RescheduleSlotChosen(this.appointmentId, this.newSlotId);
  final String appointmentId, newSlotId;
  @override
  List<Object?> get props => [appointmentId, newSlotId];
}

/// Confirms the replacement slot after the quote is displayed.
class RescheduleConfirmed extends RescheduleEvent {
  const RescheduleConfirmed();
}
