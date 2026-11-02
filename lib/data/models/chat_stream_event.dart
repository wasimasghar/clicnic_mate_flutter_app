// Represents one parsed event received from the chat stream.
// Data contains the event's decoded JSON object.

/// Holds a named server-sent event and its payload.
class ChatStreamEvent {
  const ChatStreamEvent({required this.name, required this.data});
  final String name;
  final Map<String, dynamic> data;
}
