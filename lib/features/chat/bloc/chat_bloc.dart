// Streams assistant replies into the active chat bubble.
// Requests are sequential so only one assistant reply streams at a time.

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/chat_message.dart';
import '../../../data/models/chat_response.dart';
import '../../../data/models/chat_stream_event.dart';
import '../../../data/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

/// Manages chat conversations and incremental assistant responses.
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._repository)
    : _uuid = const Uuid(),
      super(ChatState(conversationId: Uuid().v4())) {
    on<ChatStarted>(
      (event, emit) => emit(state.copyWith(status: FeatureStatus.success)),
    );
    on<ChatNewConversationStarted>((event, emit) {
      emit(
        ChatState(status: FeatureStatus.success, conversationId: _uuid.v4()),
      );
    });
    on<ChatMessageSent>(_sendMessage, transformer: sequential());
  }

  final ChatRepository _repository;
  final Uuid _uuid;

  Future<void> _sendMessage(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    final text = event.text.trim();
    if (text.isEmpty || state.isStreaming) return;
    final messages = [
      ...state.messages,
      ChatMessage(role: 'user', text: text),
      const ChatMessage(role: 'assistant', text: '', isStreaming: true),
    ];
    emit(
      state.copyWith(
        status: FeatureStatus.loading,
        messages: messages,
        clearError: true,
      ),
    );
    await emit.forEach<ChatStreamEvent>(
      _repository.sendMessage(state.conversationId, text),
      onData: (streamEvent) => _applyStreamEvent(state, streamEvent),
      onError: (Object error, StackTrace stackTrace) =>
          _showStreamError(state, error.toString()),
    );
    if (state.isStreaming) {
      final finished = _updateAssistant(
        state,
        (message) => message.copyWith(isStreaming: false),
      );
      emit(finished.copyWith(status: FeatureStatus.success));
    }
  }

  ChatState _applyStreamEvent(ChatState current, ChatStreamEvent event) {
    switch (event.name) {
      case 'status':
        final message = event.data['message'] as String? ?? '';
        return _updateAssistant(
          current,
          (bubble) => bubble.copyWith(statusText: message),
        );
      case 'token':
        final token = event.data['text'] as String? ?? '';
        return _updateAssistant(
          current,
          (bubble) =>
              bubble.copyWith(text: '${bubble.text}$token', clearStatus: true),
        );
      case 'done':
        final response = ChatResponse.fromJson(event.data);
        return _updateAssistant(
          current,
          (bubble) => bubble.copyWith(
            text: response.reply,
            isStreaming: false,
            clearStatus: true,
            doctorCards: response.doctorCards,
            bookingCard: response.bookingCard,
            sources: response.sources,
            showDisclaimer: response.showDisclaimer,
          ),
        ).copyWith(
          conversationId: response.conversationId,
          status: FeatureStatus.success,
        );
      case 'error':
        return _showStreamError(
          current,
          event.data['message'] as String? ??
              'The assistant could not complete this reply.',
        );
      default:
        return current;
    }
  }

  ChatState _showStreamError(ChatState current, String message) =>
      _updateAssistant(
        current,
        (bubble) => bubble.copyWith(
          text: message,
          isStreaming: false,
          clearStatus: true,
        ),
      ).copyWith(status: FeatureStatus.success);

  ChatState _updateAssistant(
    ChatState current,
    ChatMessage Function(ChatMessage) update,
  ) {
    final messages = [...current.messages];
    final assistantIndex = messages.lastIndexWhere(
      (message) => !message.isUser,
    );
    if (assistantIndex >= 0) {
      messages[assistantIndex] = update(messages[assistantIndex]);
    }
    return current.copyWith(messages: messages);
  }
}
