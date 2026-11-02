// Events for the assistant conversation.
// Sending and starting a conversation are explicit user actions.

import 'package:equatable/equatable.dart';

/// Base type for chat conversation actions.
sealed class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

/// Initializes the chat transcript for the current conversation.
class ChatStarted extends ChatEvent {
  const ChatStarted();
}

/// Sends a message to the assistant.
class ChatMessageSent extends ChatEvent {
  const ChatMessageSent(this.text);
  final String text;
  @override
  List<Object?> get props => [text];
}

/// Clears the transcript and starts a fresh conversation id.
class ChatNewConversationStarted extends ChatEvent {
  const ChatNewConversationStarted();
}
