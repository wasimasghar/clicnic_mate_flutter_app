// Creates the shared backend client and repositories for application injection.
// Construct once at startup and provide this object to app layers as needed.

import '../core/network/api_client.dart';
import '../core/network/sse_client.dart';
import '../core/storage/token_storage.dart';
import '../data/repositories/appointment_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/doctor_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../data/repositories/waiting_list_repository.dart';

/// Owns one token store, API client, and each repository instance.
class AppDependencies {
  AppDependencies({TokenStorage? tokenStorage, this.onUnauthorized})
    : tokenStorage = tokenStorage ?? TokenStorage() {
    apiClient = ApiClient(
      tokenStorage: this.tokenStorage,
      onUnauthorized: () => onUnauthorized?.call(),
    );
    authRepository = AuthRepository(
      apiClient: apiClient,
      tokenStorage: this.tokenStorage,
    );
    chatRepository = ChatRepository(SseClient(apiClient));
    doctorRepository = DoctorRepository(apiClient);
    appointmentRepository = AppointmentRepository(apiClient);
    waitingListRepository = WaitingListRepository(apiClient);
    profileRepository = ProfileRepository(apiClient);
  }

  final TokenStorage tokenStorage;
  void Function()? onUnauthorized;
  late final ApiClient apiClient;
  late final AuthRepository authRepository;
  late final ChatRepository chatRepository;
  late final DoctorRepository doctorRepository;
  late final AppointmentRepository appointmentRepository;
  late final WaitingListRepository waitingListRepository;
  late final ProfileRepository profileRepository;
}
