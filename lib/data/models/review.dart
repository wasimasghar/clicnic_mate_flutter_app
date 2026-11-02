// Review model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents a patient review of a doctor.
class Review {
  const Review({
    required this.reviewerName,
    required this.rating,
    this.comment,
    required this.date,
  });
  final String reviewerName, date;
  final double rating;
  final String? comment;
  factory Review.fromJson(Map<String, dynamic> json) => Review(
    reviewerName: '${json['reviewer_name'] ?? ''}',
    rating: (json['rating'] as num?)?.toDouble() ?? 0,
    comment: json['comment'] as String?,
    date: '${json['date'] ?? ''}',
  );
}
