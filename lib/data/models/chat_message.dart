// One user or assistant entry in the chat transcript.
// Carries streamed status and response cards for rendering.

import 'chat_booking_card.dart';
import 'chat_doctor_card.dart';
import 'chat_source.dart';

/// Holds a transcript bubble and any backend-provided content.
class ChatMessage {
  const ChatMessage({
    required this.role,
    required this.text,
    this.isStreaming = false,
    this.statusText,
    this.doctorCards = const [],
    this.bookingCard,
    this.sources = const [],
    this.showDisclaimer = false,
  });
  final String role, text;
  final bool isStreaming, showDisclaimer;
  final String? statusText;
  final List<ChatDoctorCard> doctorCards;
  final ChatBookingCard? bookingCard;
  final List<ChatSource> sources;
  bool get isUser => role == 'user';
  ChatMessage copyWith({
    String? text,
    bool? isStreaming,
    String? statusText,
    bool clearStatus = false,
    List<ChatDoctorCard>? doctorCards,
    ChatBookingCard? bookingCard,
    bool clearBookingCard = false,
    List<ChatSource>? sources,
    bool? showDisclaimer,
  }) => ChatMessage(
    role: role,
    text: text ?? this.text,
    isStreaming: isStreaming ?? this.isStreaming,
    statusText: clearStatus ? null : statusText ?? this.statusText,
    doctorCards: doctorCards ?? this.doctorCards,
    bookingCard: clearBookingCard ? null : bookingCard ?? this.bookingCard,
    sources: sources ?? this.sources,
    showDisclaimer: showDisclaimer ?? this.showDisclaimer,
  );
}
