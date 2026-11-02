// Events for the sign-in form.
// Submitting credentials is the sign-in user action.

import 'package:equatable/equatable.dart';

/// Base type for sign-in actions.
sealed class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object?> get props => [];
}

/// Submits a patient's phone number and password.
class SignInSubmitted extends SignInEvent {
  const SignInSubmitted(this.phone, this.password);
  final String phone, password;
  @override
  List<Object?> get props => [phone, password];
}
