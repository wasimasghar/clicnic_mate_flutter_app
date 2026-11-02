// Authenticated patient profile retrieval and partial profile updates.
// Updates only include fields supplied by the caller.

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/patient.dart';

/// Provides access to the signed-in patient's profile.
class ProfileRepository {
  const ProfileRepository(this._apiClient);
  final ApiClient _apiClient;
  Future<Patient> getMyProfile() async => Patient.fromJson(
    Map<String, dynamic>.from(await _apiClient.get(ApiEndpoints.me) as Map),
  );
  Future<Patient> updateProfile({
    String? fullName,
    String? email,
    String? city,
    String? gender,
    String? dateOfBirth,
  }) async => Patient.fromJson(
    Map<String, dynamic>.from(
      await _apiClient.patch(
            ApiEndpoints.me,
            data: {
              if (fullName != null) 'full_name': fullName,
              if (email != null) 'email': email,
              if (city != null) 'city': city,
              if (gender != null) 'gender': gender,
              if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
            },
          )
          as Map,
    ),
  );
}
