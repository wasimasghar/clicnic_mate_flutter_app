// Weekly Timing model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents one recurring weekly clinic schedule entry.
class WeeklyTiming {
  const WeeklyTiming({
    required this.day,
    required this.clinic,
    required this.area,
    required this.city,
    this.address,
    required this.start,
    required this.end,
  });
  final String day, clinic, area, city, start, end;
  final String? address;
  factory WeeklyTiming.fromJson(Map<String, dynamic> json) => WeeklyTiming(
    day: '${json['day'] ?? ''}',
    clinic: '${json['clinic'] ?? ''}',
    area: '${json['area'] ?? ''}',
    city: '${json['city'] ?? ''}',
    address: json['address'] as String?,
    start: '${json['start'] ?? ''}',
    end: '${json['end'] ?? ''}',
  );
}
