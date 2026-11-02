// State for registration details, OTP requests, and account creation.
// Keeps user-entered details available while the OTP screen is open.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/patient.dart';

/// Holds sign-up progress and the details required for OTP verification.
class SignUpState extends Equatable {
  const SignUpState({
    this.status = FeatureStatus.initial,
    this.phone,
    this.username,
    this.dateOfBirth,
    this.bio,
    this.password,
    this.patient,
    this.errorMessage,
    this.otpSent = false,
  });
  final FeatureStatus status;
  final String? phone, username, dateOfBirth, bio, password, errorMessage;
  final Patient? patient;
  final bool otpSent;
  SignUpState copyWith({
    FeatureStatus? status,
    String? phone,
    String? username,
    String? dateOfBirth,
    String? bio,
    String? password,
    Patient? patient,
    String? errorMessage,
    bool? otpSent,
    bool clearError = false,
  }) => SignUpState(
    status: status ?? this.status,
    phone: phone ?? this.phone,
    username: username ?? this.username,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    bio: bio ?? this.bio,
    password: password ?? this.password,
    patient: patient ?? this.patient,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    otpSent: otpSent ?? this.otpSent,
  );
  @override
  List<Object?> get props => [
    status,
    phone,
    username,
    dateOfBirth,
    bio,
    password,
    patient,
    errorMessage,
    otpSent,
  ];
}
