// Doctor recommendation card returned by an assistant response.
// Uses clinic and doctor fields supplied by the backend.

import 'clinic_info.dart';

/// Holds a doctor card embedded in a chat response.
class ChatDoctorCard {
  const ChatDoctorCard({
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
  });
  final String id, fullName, specialty;
  final String? qualifications, nextAvailable;
  final int experienceYears, reviewCount;
  final double consultationFee, rating;
  final List<ClinicInfo> clinics;
  factory ChatDoctorCard.fromJson(Map<String, dynamic> json) => ChatDoctorCard(
    id: '${json['id'] ?? ''}',
    fullName: '${json['full_name'] ?? ''}',
    specialty: '${json['specialty'] ?? ''}',
    qualifications: json['qualifications'] as String?,
    experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
    consultationFee: (json['consultation_fee'] as num?)?.toDouble() ?? 0,
    rating: (json['rating'] as num?)?.toDouble() ?? 0,
    reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
    clinics: (json['clinics'] as List? ?? const [])
        .map(
          (value) =>
              ClinicInfo.fromJson(Map<String, dynamic>.from(value as Map)),
        )
        .toList(),
    nextAvailable: json['next_available'] as String?,
  );
}
