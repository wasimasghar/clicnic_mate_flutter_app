// State for the streaming chat transcript.
// Includes the current conversation id and whether a response is streaming.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/chat_message.dart';

/// Holds chat messages, conversation identity, and request state.
class ChatState extends Equatable {
  const ChatState({
    this.status = FeatureStatus.initial,
    required this.conversationId,
    this.messages = const [],
    this.errorMessage,
  });
  final FeatureStatus status;
  final String conversationId;
  final List<ChatMessage> messages;
  final String? errorMessage;
  bool get isStreaming => messages.any((message) => message.isStreaming);
  ChatState copyWith({
    FeatureStatus? status,
    String? conversationId,
    List<ChatMessage>? messages,
    String? errorMessage,
    bool clearError = false,
  }) => ChatState(
    status: status ?? this.status,
    conversationId: conversationId ?? this.conversationId,
    messages: messages ?? this.messages,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [status, conversationId, messages, errorMessage];
}
