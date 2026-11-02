// Events that change the authenticated session.
// Session events are small immutable values for Bloc processing.

import 'package:equatable/equatable.dart';

/// Base type for authentication session events.
sealed class SessionEvent extends Equatable {
  const SessionEvent();
  @override
  List<Object?> get props => [];
}

/// Requests session restoration from secure storage.
class SessionStarted extends SessionEvent {
  const SessionStarted();
}

/// Marks a successful authentication.
class SessionSignedIn extends SessionEvent {
  const SessionSignedIn();
}

/// Clears credentials and signs the patient out.
class SessionSignedOut extends SessionEvent {
  const SessionSignedOut();
}

/// Handles an expired or rejected API token.
class SessionExpired extends SessionEvent {
  const SessionExpired();
}
