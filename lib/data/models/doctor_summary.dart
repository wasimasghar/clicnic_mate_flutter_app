// Doctor Summary model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

import 'clinic_info.dart';

/// Compact doctor details used in search results.
class DoctorSummary {
  const DoctorSummary({
    required this.id,
    required this.fullName,
    required this.specialty,
    this.qualifications,
    required this.experienceYears,
    required this.consultationFee,
    required this.rating,
    required this.reviewCount,
    required this.clinics,
    this.nextAvailable,
    required this.gender,
    required this.languages,
  });
  final String id, fullName, specialty, gender;
  final String? qualifications, nextAvailable;
  final int experienceYears, reviewCount;
  final double consultationFee, rating;
  final List<ClinicInfo> clinics;
  final List<String> languages;
  factory DoctorSummary.fromJson(Map<String, dynamic> json) => DoctorSummary(
    id: '${json['id'] ?? ''}',
    fullName: '${json['full_name'] ?? ''}',
    specialty: '${json['specialty'] ?? ''}',
    qualifications: json['qualifications'] as String?,
    experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
    consultationFee: (json['consultation_fee'] as num?)?.toDouble() ?? 0,
    rating: (json['rating'] as num?)?.toDouble() ?? 0,
    reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
    clinics: (json['clinics'] as List? ?? const [])
        .map((e) => ClinicInfo.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    nextAvailable: json['next_available'] as String?,
    gender: '${json['gender'] ?? ''}',
    languages: List<String>.from(json['languages'] as List? ?? const []),
  );
}
