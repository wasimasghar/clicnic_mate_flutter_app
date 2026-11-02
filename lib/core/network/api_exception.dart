// Normalized exception for API failures returned by the ClinicMate backend.
// Extracts readable messages from standard detail responses and validation errors.

/// Describes an HTTP failure with its status code and backend message.
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int? statusCode;
  final String message;

  bool get isUnauthorized => statusCode == 401;
  bool get isConflict => statusCode == 409;
  bool get isNotFound => statusCode == 404;

  @override
  String toString() => message;

  static ApiException fromResponse(int? statusCode, dynamic body) {
    var message = 'Unable to complete the request.';
    if (body is Map) {
      final detail = body['detail'];
      if (detail is String && detail.isNotEmpty) {
        message = detail;
      } else if (detail is List && detail.isNotEmpty && detail.first is Map) {
        final firstMessage = detail.first['msg'];
        if (firstMessage is String && firstMessage.isNotEmpty) {
          message = firstMessage;
        }
      }
    }
    return ApiException(statusCode, message);
  }
}
