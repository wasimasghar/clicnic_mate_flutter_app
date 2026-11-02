// Booking Quote model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents the price and location details for a selected slot.
class BookingQuote {
  const BookingQuote({
    required this.slotId,
    required this.date,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.consultationFee,
    required this.clinic,
    required this.area,
    this.address,
    required this.city,
  });
  final String slotId,
      date,
      day,
      startTime,
      endTime,
      doctorId,
      doctorName,
      specialty,
      clinic,
      area,
      city;
  final String? address;
  final double consultationFee;
  factory BookingQuote.fromJson(Map<String, dynamic> j) => BookingQuote(
    slotId: '${j['slot_id'] ?? ''}',
    date: '${j['date'] ?? ''}',
    day: '${j['day'] ?? ''}',
    startTime: '${j['start_time'] ?? ''}',
    endTime: '${j['end_time'] ?? ''}',
    doctorId: '${j['doctor_id'] ?? ''}',
    doctorName: '${j['doctor_name'] ?? ''}',
    specialty: '${j['specialty'] ?? ''}',
    consultationFee: (j['consultation_fee'] as num?)?.toDouble() ?? 0,
    clinic: '${j['clinic'] ?? ''}',
    area: '${j['area'] ?? ''}',
    address: j['address'] as String?,
    city: '${j['city'] ?? ''}',
  );
}
