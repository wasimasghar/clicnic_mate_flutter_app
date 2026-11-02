// Patient waiting-list operations for doctors with unavailable appointments.
// Supports listing, joining, and leaving a waiting list.

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../models/waiting_list_entry.dart';

/// Manages authenticated waiting-list entries.
class WaitingListRepository {
  const WaitingListRepository(this._apiClient);
  final ApiClient _apiClient;
  Future<List<WaitingListEntry>> getMyWaitingList() async =>
      (await _apiClient.get(ApiEndpoints.waitingList) as List)
          .map(
            (e) =>
                WaitingListEntry.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
  Future<Map<String, dynamic>> join({
    required String doctorId,
    String? preferredDate,
  }) async => Map<String, dynamic>.from(
    await _apiClient.post(
          ApiEndpoints.waitingList,
          data: {
            'doctor_id': doctorId,
            if (preferredDate != null) 'preferred_date': preferredDate,
          },
        )
        as Map,
  );
  Future<bool> leave(String waitingId) async =>
      (await _apiClient.delete(ApiEndpoints.waitingEntry(waitingId))
              as Map)['left']
          as bool? ??
      false;
}
