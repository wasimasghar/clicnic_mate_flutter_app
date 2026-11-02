// Appointment quote or result card returned in a chat response.
// Card kind indicates whether the slot is quoted or booked.

/// Holds booking details embedded in an assistant response.
class ChatBookingCard {
  const ChatBookingCard({
    required this.kind,
    this.slotId,
    this.appointmentId,
    required this.doctorName,
    required this.specialty,
    required this.clinic,
    required this.area,
    required this.city,
    required this.date,
    required this.day,
    required this.startTime,
    required this.consultationFee,
  });
  final String kind,
      doctorName,
      specialty,
      clinic,
      area,
      city,
      date,
      day,
      startTime;
  final String? slotId, appointmentId;
  final double consultationFee;
  factory ChatBookingCard.fromJson(Map<String, dynamic> json) =>
      ChatBookingCard(
        kind: '${json['kind'] ?? ''}',
        slotId: json['slot_id'] as String?,
        appointmentId: json['appointment_id'] as String?,
        doctorName: '${json['doctor_name'] ?? ''}',
        specialty: '${json['specialty'] ?? ''}',
        clinic: '${json['clinic'] ?? ''}',
        area: '${json['area'] ?? ''}',
        city: '${json['city'] ?? ''}',
        date: '${json['date'] ?? ''}',
        day: '${json['day'] ?? ''}',
        startTime: '${json['start_time'] ?? ''}',
        consultationFee: (json['consultation_fee'] as num?)?.toDouble() ?? 0,
      );
}
