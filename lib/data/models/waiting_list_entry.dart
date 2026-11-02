// Waiting List Entry model for ClinicMate backend data.
// Converts the backend snake_case JSON fields to immutable Dart values.

/// Represents the patient's place on a doctor's waiting list.
class WaitingListEntry {
  const WaitingListEntry({
    required this.waitingId,
    required this.status,
    required this.doctorId,
    required this.doctorName,
    this.preferredDate,
    this.offeredSlotId,
    this.offeredTime,
    this.offerExpiresAt,
  });
  final String waitingId, status, doctorId, doctorName;
  final String? preferredDate, offeredSlotId, offeredTime, offerExpiresAt;
  factory WaitingListEntry.fromJson(Map<String, dynamic> j) => WaitingListEntry(
    waitingId: '${j['waiting_id'] ?? ''}',
    status: '${j['status'] ?? ''}',
    doctorId: '${j['doctor_id'] ?? ''}',
    doctorName: '${j['doctor_name'] ?? ''}',
    preferredDate: j['preferred_date'] as String?,
    offeredSlotId: j['offered_slot_id'] as String?,
    offeredTime: j['offered_time'] as String?,
    offerExpiresAt: j['offer_expires_at'] as String?,
  );
}
