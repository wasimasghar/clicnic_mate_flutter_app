// State for patient sign-in submission.
// Contains validation-independent request status and error text.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/patient.dart';

/// Holds sign-in progress and the authenticated patient when available.
class SignInState extends Equatable {
  const SignInState({
    this.status = FeatureStatus.initial,
    this.patient,
    this.errorMessage,
  });
  final FeatureStatus status;
  final Patient? patient;
  final String? errorMessage;
  SignInState copyWith({
    FeatureStatus? status,
    Patient? patient,
    String? errorMessage,
    bool clearError = false,
  }) => SignInState(
    status: status ?? this.status,
    patient: patient ?? this.patient,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [status, patient, errorMessage];
}
