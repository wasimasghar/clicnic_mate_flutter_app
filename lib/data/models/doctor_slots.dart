// Doctor Slots model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents a doctor's available booking slots over several days.
class DoctorSlots {
  const DoctorSlots({
    required this.today,
    required this.doctorId,
    required this.days,
  });
  final String today, doctorId;
  final List<SlotDay> days;
  factory DoctorSlots.fromJson(Map<String, dynamic> j) => DoctorSlots(
    today: '${j['today'] ?? ''}',
    doctorId: '${j['doctor_id'] ?? ''}',
    days: (j['days'] as List? ?? const [])
        .map((e) => SlotDay.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

/// Available appointment times for one date and clinic.
class SlotDay {
  const SlotDay({
    required this.date,
    required this.day,
    required this.clinic,
    required this.area,
    required this.city,
    required this.times,
  });
  final String date, day, clinic, area, city;
  final List<SlotTime> times;
  factory SlotDay.fromJson(Map<String, dynamic> j) => SlotDay(
    date: '${j['date'] ?? ''}',
    day: '${j['day'] ?? ''}',
    clinic: '${j['clinic'] ?? ''}',
    area: '${j['area'] ?? ''}',
    city: '${j['city'] ?? ''}',
    times: (j['times'] as List? ?? const [])
        .map((e) => SlotTime.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

/// Identifies an individual available booking time.
class SlotTime {
  const SlotTime({required this.slotId, required this.time});
  final String slotId, time;
  factory SlotTime.fromJson(Map<String, dynamic> j) =>
      SlotTime(slotId: '${j['slot_id'] ?? ''}', time: '${j['time'] ?? ''}');
}
