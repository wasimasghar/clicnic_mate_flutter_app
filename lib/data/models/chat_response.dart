// Final assistant response after a streamed chat answer completes.
// Converts nested cards and sources from backend JSON.

import 'chat_booking_card.dart';
import 'chat_doctor_card.dart';
import 'chat_source.dart';

/// Holds the complete assistant response and conversation identifier.
class ChatResponse {
  const ChatResponse({
    required this.conversationId,
    required this.reply,
    required this.doctorCards,
    this.bookingCard,
    required this.sources,
    required this.showDisclaimer,
  });
  final String conversationId, reply;
  final List<ChatDoctorCard> doctorCards;
  final ChatBookingCard? bookingCard;
  final List<ChatSource> sources;
  final bool showDisclaimer;
  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
    conversationId: '${json['conversation_id'] ?? ''}',
    reply: '${json['reply'] ?? ''}',
    doctorCards: (json['doctor_cards'] as List? ?? const [])
        .map(
          (value) =>
              ChatDoctorCard.fromJson(Map<String, dynamic>.from(value as Map)),
        )
        .toList(),
    bookingCard: json['booking_card'] is Map
        ? ChatBookingCard.fromJson(
            Map<String, dynamic>.from(json['booking_card'] as Map),
          )
        : null,
    sources: (json['sources'] as List? ?? const [])
        .map(
          (value) =>
              ChatSource.fromJson(Map<String, dynamic>.from(value as Map)),
        )
        .toList(),
    showDisclaimer: json['show_disclaimer'] as bool? ?? false,
  );
}
