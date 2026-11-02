// Backend route constants and route builders used by repositories.
// Keeping paths here makes endpoint changes easy to review.

/// Defines the ClinicMate API paths.
class ApiEndpoints {
  ApiEndpoints._();

  static const authSendOtp = '/auth/send-otp';
  static const authSignUp = '/auth/signup';
  static const authLogin = '/auth/login';
  static const specialties = '/specialties';
  static const cities = '/cities';
  static const doctors = '/doctors';
  static String doctor(String id) => '$doctors/${Uri.encodeComponent(id)}';
  static String doctorReviews(String id) => '${doctor(id)}/reviews';
  static String doctorSlots(String id) => '${doctor(id)}/slots';
  static String slotQuote(String id) =>
      '/slots/${Uri.encodeComponent(id)}/quote';
  static const appointments = '/appointments';
  static String appointmentCancel(String id) => '${appointment(id)}/cancel';
  static String appointmentReschedule(String id) =>
      '${appointment(id)}/reschedule';
  static String appointmentReview(String id) => '${appointment(id)}/review';
  static String appointment(String id) =>
      '$appointments/${Uri.encodeComponent(id)}';
  static const waitingList = '/waiting-list';
  static String waitingEntry(String id) =>
      '$waitingList/${Uri.encodeComponent(id)}';
  static const me = '/me';
  static const chatStream = '/chat/stream';
}
