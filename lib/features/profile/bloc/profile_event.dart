// Events for profile loading, updates, and sign-out.
// Update events contain the values currently shown in the edit form.

import 'package:equatable/equatable.dart';

/// Base type for patient profile actions.
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

/// Loads the patient's profile and available city values.
class ProfileRequested extends ProfileEvent {
  const ProfileRequested();
}

/// Saves changed patient profile fields.
class ProfileUpdated extends ProfileEvent {
  const ProfileUpdated({
    this.fullName,
    this.email,
    this.city,
    this.gender,
    this.dateOfBirth,
  });
  final String? fullName, email, city, gender, dateOfBirth;
  @override
  List<Object?> get props => [fullName, email, city, gender, dateOfBirth];
}

/// Signs out by updating the shared session.
class ProfileSignOutPressed extends ProfileEvent {
  const ProfileSignOutPressed();
}
