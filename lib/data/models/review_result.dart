// Review Result model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Summarizes the updated doctor rating after a review is submitted.
class ReviewResult {
  const ReviewResult({
    required this.doctorId,
    required this.doctorName,
    required this.newRating,
    required this.reviewCount,
  });
  final String doctorId, doctorName;
  final double newRating;
  final int reviewCount;
  factory ReviewResult.fromJson(Map<String, dynamic> j) => ReviewResult(
    doctorId: '${j['doctor_id'] ?? ''}',
    doctorName: '${j['doctor_name'] ?? ''}',
    newRating: (j['new_rating'] as num?)?.toDouble() ?? 0,
    reviewCount: (j['review_count'] as num?)?.toInt() ?? 0,
  );
}
