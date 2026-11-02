// Patient appointment listing, booking, cancellation, rescheduling, and reviews.
// Booking and rescheduling callers should fetch a quote before submitting.

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/appointment.dart';
import '../models/review_result.dart';

/// Manages authenticated appointment operations.
class AppointmentRepository {
  const AppointmentRepository(this._apiClient);
  final ApiClient _apiClient;
  Future<List<Appointment>> getMyAppointments({
    required bool upcomingOnly,
  }) async =>
      (await _apiClient.get(
                ApiEndpoints.appointments,
                queryParameters: {'upcoming_only': upcomingOnly},
              )
              as List)
          .map((e) => Appointment.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
  Future<Appointment> book({required String slotId, String? reason}) async =>
      Appointment.fromJson(
        Map<String, dynamic>.from(
          await _apiClient.post(
                ApiEndpoints.appointments,
                data: {'slot_id': slotId, if (reason != null) 'reason': reason},
              )
              as Map,
        ),
      );
  Future<Appointment> cancel(String appointmentId) async =>
      Appointment.fromJson(
        Map<String, dynamic>.from(
          await _apiClient.post(ApiEndpoints.appointmentCancel(appointmentId))
              as Map,
        ),
      );
  Future<Appointment> reschedule({
    required String appointmentId,
    required String newSlotId,
  }) async => Appointment.fromJson(
    Map<String, dynamic>.from(
      await _apiClient.post(
            ApiEndpoints.appointmentReschedule(appointmentId),
            data: {'new_slot_id': newSlotId},
          )
          as Map,
    ),
  );
  Future<ReviewResult> addReview({
    required String appointmentId,
    required int rating,
    String? comment,
  }) async => ReviewResult.fromJson(
    Map<String, dynamic>.from(
      await _apiClient.post(
            ApiEndpoints.appointmentReview(appointmentId),
            data: {'rating': rating, if (comment != null) 'comment': comment},
          )
          as Map,
    ),
  );
}
