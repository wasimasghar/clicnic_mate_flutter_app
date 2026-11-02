// Runtime configuration for the ClinicMate backend.
// Override the backend URL with the API_BASE_URL build define.

/// Holds environment-specific application settings.
class AppConfig {
  AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );
}
