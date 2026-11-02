// Sends assistant prompts and exposes the backend's streamed response events.
// Uses the shared API client so authorization and error handling stay consistent.

import '../../core/network/api_endpoints.dart';
import '../../core/network/sse_client.dart';
import '../models/chat_stream_event.dart';

/// Provides the ClinicMate assistant message stream.
class ChatRepository {
  const ChatRepository(this._sseClient);
  final SseClient _sseClient;
  Stream<ChatStreamEvent> sendMessage(String conversationId, String message) =>
      _sseClient.post(ApiEndpoints.chatStream, {
        'conversation_id': conversationId,
        'message': message,
      });
}
