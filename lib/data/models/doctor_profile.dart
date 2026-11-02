// Doctor Profile model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

import 'review.dart';
import 'weekly_timing.dart';

/// Full public details for one doctor.
class DoctorProfile {
  const DoctorProfile({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.specialty,
    this.qualifications,
    required this.experienceYears,
    required this.consultationFee,
    required this.rating,
    required this.reviewCount,
    required this.languages,
    this.about,
    this.reviewSummary,
    required this.weeklySchedule,
    required this.latestReviews,
  });
  final String id, fullName, gender, specialty;
  final String? qualifications, about, reviewSummary;
  final int experienceYears, reviewCount;
  final double consultationFee, rating;
  final List<String> languages;
  final List<WeeklyTiming> weeklySchedule;
  final List<Review> latestReviews;
  factory DoctorProfile.fromJson(Map<String, dynamic> j) => DoctorProfile(
    id: '${j['id'] ?? ''}',
    fullName: '${j['full_name'] ?? ''}',
    gender: '${j['gender'] ?? ''}',
    specialty: '${j['specialty'] ?? ''}',
    qualifications: j['qualifications'] as String?,
    experienceYears: (j['experience_years'] as num?)?.toInt() ?? 0,
    consultationFee: (j['consultation_fee'] as num?)?.toDouble() ?? 0,
    rating: (j['rating'] as num?)?.toDouble() ?? 0,
    reviewCount: (j['review_count'] as num?)?.toInt() ?? 0,
    languages: List<String>.from(j['languages'] as List? ?? const []),
    about: j['about'] as String?,
    reviewSummary: j['review_summary'] as String?,
    weeklySchedule: (j['weekly_schedule'] as List? ?? const [])
        .map((e) => WeeklyTiming.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    latestReviews: (j['latest_reviews'] as List? ?? const [])
        .map((e) => Review.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}
