// City model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents a city and its available clinic areas.
class City {
  const City({
    required this.name,
    this.nameUrdu,
    required this.areas,
    required this.doctorCount,
  });
  final String name;
  final String? nameUrdu;
  final List<String> areas;
  final int doctorCount;
  factory City.fromJson(Map<String, dynamic> json) => City(
    name: '${json['name'] ?? ''}',
    nameUrdu: json['name_urdu'] as String?,
    areas: List<String>.from(json['areas'] as List? ?? const []),
    doctorCount: (json['doctor_count'] as num?)?.toInt() ?? 0,
  );
}
