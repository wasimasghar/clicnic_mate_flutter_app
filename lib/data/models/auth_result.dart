// Auth Result model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

import 'patient.dart';

/// Represents a successful authentication response.
class AuthResult {
  const AuthResult({
    required this.token,
    required this.expiresInDays,
    required this.patient,
  });
  final String token;
  final int expiresInDays;
  final Patient patient;
  factory AuthResult.fromJson(Map<String, dynamic> json) => AuthResult(
    token: '${json['token'] ?? ''}',
    expiresInDays: (json['expires_in_days'] as num?)?.toInt() ?? 0,
    patient: Patient.fromJson(
      Map<String, dynamic>.from(json['patient'] as Map),
    ),
  );
}
