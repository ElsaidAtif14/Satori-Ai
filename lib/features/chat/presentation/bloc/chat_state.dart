import 'package:test_ai/features/chat/data/models/chat_message.dart';
import 'package:test_ai/features/chat/data/models/chat_session_model.dart';

abstract class ChatState {
  final List<ChatSessionModel> sessions;
  final List<ChatMessage> messages;
  final String? activeChatId;

  const ChatState({
    this.sessions = const [],
    this.messages = const [],
    this.activeChatId,
  });
}

class ChatInitial extends ChatState {}

class ChatSessionsLoading extends ChatState {}

class ChatLoaded extends ChatState {
  const ChatLoaded({
    super.sessions,
    super.messages,
    super.activeChatId,
  });
}

class ChatSendingMessage extends ChatState {
  const ChatSendingMessage({
    super.sessions,
    super.messages,
    super.activeChatId,
  });
}

class ChatFailure extends ChatState {
  final String errorMessage;
  const ChatFailure(
    this.errorMessage, {
    super.sessions,
    super.messages,
    super.activeChatId,
  });
}
