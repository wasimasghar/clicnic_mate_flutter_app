// Appointment model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents a booked, cancelled, completed, or missed appointment.
class Appointment {
  const Appointment({
    required this.appointmentId,
    required this.status,
    this.reason,
    required this.date,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.isUpcoming,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.consultationFee,
    required this.clinic,
    required this.area,
    this.address,
    required this.city,
  });
  final String appointmentId,
      status,
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
  final String? reason, address;
  final bool isUpcoming;
  final double consultationFee;
  factory Appointment.fromJson(Map<String, dynamic> j) => Appointment(
    appointmentId: '${j['appointment_id'] ?? ''}',
    status: '${j['status'] ?? ''}',
    reason: j['reason'] as String?,
    date: '${j['date'] ?? ''}',
    day: '${j['day'] ?? ''}',
    startTime: '${j['start_time'] ?? ''}',
    endTime: '${j['end_time'] ?? ''}',
    isUpcoming: j['is_upcoming'] as bool? ?? false,
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
