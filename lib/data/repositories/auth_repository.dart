// Authentication operations for OTP, registration, and sign-in.
// Successful authentication stores its bearer token securely.

import '../../core/network/api_client.dart';
import '../../core/network/api_endpoints.dart';
import '../../core/storage/token_storage.dart';
import '../models/auth_result.dart';

/// Provides authentication operations backed by the ClinicMate API.
class AuthRepository {
  AuthRepository({
    required ApiClient apiClient,
    required TokenStorage tokenStorage,
  }) : _apiClient = apiClient,
       _tokenStorage = tokenStorage;
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  Future<Map<String, dynamic>> sendOtp(String phone) async =>
      Map<String, dynamic>.from(
        await _apiClient.post(ApiEndpoints.authSendOtp, data: {'phone': phone})
            as Map,
      );
  Future<AuthResult> signUp({
    required String phone,
    required String username,
    required String dateOfBirth,
    String? bio,
    required String password,
    required String otp,
  }) async {
    final result = AuthResult.fromJson(
      Map<String, dynamic>.from(
        await _apiClient.post(
              ApiEndpoints.authSignUp,
              data: {
                'phone': phone,
                'username': username,
                'date_of_birth': dateOfBirth,
                if (bio != null) 'bio': bio,
                'password': password,
                'otp': otp,
              },
            )
            as Map,
      ),
    );
    await _tokenStorage.saveToken(result.token);
    return result;
  }

  Future<AuthResult> signIn({
    required String phone,
    required String password,
  }) async {
    final result = AuthResult.fromJson(
      Map<String, dynamic>.from(
        await _apiClient.post(
              ApiEndpoints.authLogin,
              data: {'phone': phone, 'password': password},
            )
            as Map,
      ),
    );
    await _tokenStorage.saveToken(result.token);
    return result;
  }

  Future<void> signOut() => _tokenStorage.clearToken();
  Future<bool> isSignedIn() async =>
      (await _tokenStorage.readToken())?.isNotEmpty ?? false;
}
