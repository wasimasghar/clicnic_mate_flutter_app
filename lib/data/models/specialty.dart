// Specialty model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents a medical specialty in the directory.
class Specialty {
  const Specialty({
    required this.name,
    this.nameUrdu,
    this.description,
    required this.doctorCount,
  });
  final String name;
  final String? nameUrdu, description;
  final int doctorCount;
  factory Specialty.fromJson(Map<String, dynamic> json) => Specialty(
    name: '${json['name'] ?? ''}',
    nameUrdu: json['name_urdu'] as String?,
    description: json['description'] as String?,
    doctorCount: (json['doctor_count'] as num?)?.toInt() ?? 0,
  );
}
