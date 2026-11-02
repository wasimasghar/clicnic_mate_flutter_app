// Patient model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents a patient account and profile.
class Patient {
  const Patient({
    required this.id,
    required this.fullName,
    this.username,
    this.bio,
    required this.phone,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.city,
  });
  final String id, fullName, phone;
  final String? username, bio, email, gender, dateOfBirth, city;
  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: '${json['id'] ?? ''}',
    fullName: '${json['full_name'] ?? ''}',
    phone: '${json['phone'] ?? ''}',
    username: json['username'] as String?,
    bio: json['bio'] as String?,
    email: json['email'] as String?,
    gender: json['gender'] as String?,
    dateOfBirth: json['date_of_birth'] as String?,
    city: json['city'] as String?,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'username': username,
    'bio': bio,
    'phone': phone,
    'email': email,
    'gender': gender,
    'date_of_birth': dateOfBirth,
    'city': city,
  };
}
