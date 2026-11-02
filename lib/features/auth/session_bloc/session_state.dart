// State for secure session restoration and sign-in status.
// Holds a shared feature status and authentication flag.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';

/// Represents whether a stored patient session is available.
class SessionState extends Equatable {
  const SessionState({
    this.status = FeatureStatus.initial,
    this.isSignedIn = false,
    this.errorMessage,
  });
  final FeatureStatus status;
  final bool isSignedIn;
  final String? errorMessage;
  SessionState copyWith({
    FeatureStatus? status,
    bool? isSignedIn,
    String? errorMessage,
    bool clearError = false,
  }) => SessionState(
    status: status ?? this.status,
    isSignedIn: isSignedIn ?? this.isSignedIn,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [status, isSignedIn, errorMessage];
}
