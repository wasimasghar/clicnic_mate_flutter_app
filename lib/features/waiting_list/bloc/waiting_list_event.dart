// Events for loading and leaving patient waiting-list entries.
// Leaving is dispatched after the patient's tap action.

import 'package:equatable/equatable.dart';

/// Base type for waiting-list actions.
sealed class WaitingListEvent extends Equatable {
  const WaitingListEvent();
  @override
  List<Object?> get props => [];
}

/// Loads the current patient's waiting-list entries.
class WaitingListRequested extends WaitingListEvent {
  const WaitingListRequested();
}

/// Removes one waiting-list entry.
class WaitingListLeft extends WaitingListEvent {
  const WaitingListLeft(this.waitingId);
  final String waitingId;
  @override
  List<Object?> get props => [waitingId];
}
