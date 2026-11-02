// Doctor Search Filters model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Holds optional doctor search criteria and serializes them as query parameters.
class DoctorSearchFilters {
  const DoctorSearchFilters({
    this.specialty,
    this.city,
    this.area,
    this.gender,
    this.language,
    this.maxFee,
    this.minRating,
    this.need,
    this.sortBy,
    this.limit,
  });
  final String? specialty, city, area, gender, language, need, sortBy;
  final num? maxFee, minRating;
  final int? limit;
  Map<String, dynamic> toQueryParameters() => {
    if (specialty != null) 'specialty': specialty,
    if (city != null) 'city': city,
    if (area != null) 'area': area,
    if (gender != null) 'gender': gender,
    if (language != null) 'language': language,
    if (maxFee != null) 'max_fee': maxFee,
    if (minRating != null) 'min_rating': minRating,
    if (need != null) 'need': need,
    if (sortBy != null) 'sort_by': sortBy,
    if (limit != null) 'limit': limit,
  };
}
