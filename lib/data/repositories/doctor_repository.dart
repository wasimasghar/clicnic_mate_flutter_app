// Read-only directory, doctor, review, availability, and quote operations.
// Public directory endpoints are available without a patient login.

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/booking_quote.dart';
import '../models/city.dart';
import '../models/doctor_profile.dart';
import '../models/doctor_search_filters.dart';
import '../models/doctor_slots.dart';
import '../models/doctor_summary.dart';
import '../models/review.dart';
import '../models/specialty.dart';

/// Loads doctor directory data from the ClinicMate API.
class DoctorRepository {
  const DoctorRepository(this._apiClient);
  final ApiClient _apiClient;
  Future<List<Specialty>> getSpecialties() async =>
      (await _apiClient.get(ApiEndpoints.specialties) as List)
          .map((e) => Specialty.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
  Future<List<City>> getCities() async =>
      (await _apiClient.get(ApiEndpoints.cities) as List)
          .map((e) => City.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
  Future<List<DoctorSummary>> searchDoctors(
    DoctorSearchFilters filters,
  ) async =>
      (await _apiClient.get(
                ApiEndpoints.doctors,
                queryParameters: filters.toQueryParameters(),
              )
              as List)
          .map(
            (e) => DoctorSummary.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
  Future<DoctorProfile> getDoctorProfile(String doctorId) async =>
      DoctorProfile.fromJson(
        Map<String, dynamic>.from(
          await _apiClient.get(ApiEndpoints.doctor(doctorId)) as Map,
        ),
      );
  Future<List<Review>> getReviews(String doctorId, {int? limit}) async =>
      (await _apiClient.get(
                ApiEndpoints.doctorReviews(doctorId),
                queryParameters: {if (limit != null) 'limit': limit},
              )
              as List)
          .map((e) => Review.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
  Future<DoctorSlots> getSlots(
    String doctorId, {
    String? dateFrom,
    String? dateTo,
    String? timeOfDay,
    int? limit,
  }) async => DoctorSlots.fromJson(
    Map<String, dynamic>.from(
      await _apiClient.get(
            ApiEndpoints.doctorSlots(doctorId),
            queryParameters: {
              if (dateFrom != null) 'date_from': dateFrom,
              if (dateTo != null) 'date_to': dateTo,
              if (timeOfDay != null) 'time_of_day': timeOfDay,
              if (limit != null) 'limit': limit,
            },
          )
          as Map,
    ),
  );
  Future<BookingQuote> getQuote(String slotId) async => BookingQuote.fromJson(
    Map<String, dynamic>.from(
      await _apiClient.get(ApiEndpoints.slotQuote(slotId)) as Map,
    ),
  );
}
