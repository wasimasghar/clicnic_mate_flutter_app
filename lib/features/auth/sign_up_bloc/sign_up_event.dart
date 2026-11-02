// Events for the account creation and OTP flow.
// Form data travels through events instead of screen-side API calls.

import 'package:equatable/equatable.dart';

/// Base type for sign-up actions.
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

/// Submits registration details and requests a verification code.
class SignUpDetailsSubmitted extends SignUpEvent {
  const SignUpDetailsSubmitted({
    required this.phone,
    required this.username,
    required this.dateOfBirth,
    this.bio,
    required this.password,
  });
  final String phone, username, dateOfBirth, password;
  final String? bio;
  @override
  List<Object?> get props => [phone, username, dateOfBirth, bio, password];
}

/// Submits the verification code for the saved registration details.
class SignUpOtpSubmitted extends SignUpEvent {
  const SignUpOtpSubmitted(this.otp);
  final String otp;
  @override
  List<Object?> get props => [otp];
}

/// Requests another verification code for the saved phone number.
class SignUpOtpResent extends SignUpEvent {
  const SignUpOtpResent();
}
