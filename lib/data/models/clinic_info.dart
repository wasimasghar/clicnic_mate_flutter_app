// Clinic Info model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents a clinic location shown with a doctor.
class ClinicInfo {
  const ClinicInfo({
    required this.clinic,
    required this.area,
    required this.city,
  });
  final String clinic, area, city;
  factory ClinicInfo.fromJson(Map<String, dynamic> json) => ClinicInfo(
    clinic: '${json['clinic'] ?? ''}',
    area: '${json['area'] ?? ''}',
    city: '${json['city'] ?? ''}',
  );
}
