import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ai/core/helper/get_user.dart';
import 'package:test_ai/features/chat/data/models/chat_message.dart';
import 'package:test_ai/features/chat/data/models/chat_session_model.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final ChatRepository chatRepository;

  ChatBloc({
    required this.sendMessageUseCase,
    required this.chatRepository,
  }) : super(ChatInitial()) {
    on<LoadChatSessionsEvent>(_onLoadChatSessions);
    on<SelectChatSessionEvent>(_onSelectChatSession);
    on<StartNewChatEvent>(_onStartNewChat);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onLoadChatSessions(
    LoadChatSessionsEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatSessionsLoading());
    final userId = getUser().uId;

    final sessionsResult = await chatRepository.getChatSessions(userId);
    await sessionsResult.fold((failure) async {
      emit(ChatFailure(failure.message));
    }, (sessions) async {
      if (sessions.isEmpty) {
        emit(const ChatLoaded(sessions: [], messages: [], activeChatId: null));
        return;
      }

      final activeChatId = sessions.first.id;
      final messagesResult = await chatRepository.getChatMessages(userId, activeChatId);
      messagesResult.fold(
        (failure) => emit(ChatFailure(failure.message)),
        (messages) => emit(ChatLoaded(
          sessions: sessions,
          messages: messages,
          activeChatId: activeChatId,
        )),
      );
    });
  }

  Future<void> _onSelectChatSession(
    SelectChatSessionEvent event,
    Emitter<ChatState> emit,
  ) async {
    final userId = getUser().uId;
    emit(ChatSessionsLoading());

    final sessions = state.sessions;
    final messagesResult = await chatRepository.getChatMessages(userId, event.chatId);
    messagesResult.fold(
      (failure) => emit(ChatFailure(failure.message)),
      (messages) => emit(ChatLoaded(
        sessions: sessions,
        messages: messages,
        activeChatId: event.chatId,
      )),
    );
  }

  Future<void> _onStartNewChat(
    StartNewChatEvent event,
    Emitter<ChatState> emit,
  ) async {
    final userId = getUser().uId;
    final createResult = await chatRepository.createChatSession(userId, 'New Chat');

    createResult.fold((failure) {
      emit(ChatFailure(failure.message));
    }, (session) {
      final sessions = [session, ...state.sessions];
      emit(ChatLoaded(
        sessions: sessions,
        messages: [],
        activeChatId: session.id,
      ));
    });
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final userId = getUser().uId;
    String? activeChatId = state.activeChatId;
    var sessions = state.sessions;
    var messages = List<ChatMessage>.from(state.messages);

    if (activeChatId == null) {
      final createResult = await chatRepository.createChatSession(userId, 'New Chat');
      final newSessionResult = createResult.fold<ChatSessionModel?>(
        (_) => null,
        (session) => session,
      );

      if (newSessionResult == null) {
        emit(const ChatFailure('Failed to create a new chat session.'));
        return;
      }

      activeChatId = newSessionResult.id;
      sessions = [newSessionResult, ...sessions];
      messages = [];
    }

    final userMessage = ChatMessage.user(event.message);
    messages.add(userMessage);
    emit(ChatSendingMessage(
      sessions: sessions,
      messages: messages,
      activeChatId: activeChatId,
    ));

    final saveUserResult = await chatRepository.saveMessage(
      userId,
      activeChatId,
      userMessage,
    );

    if (saveUserResult.isLeft()) {
      saveUserResult.fold((failure) {
        emit(ChatFailure(failure.message));
      }, (_) {});
      return;
    }

    final geminiResult = await sendMessageUseCase.call(event.message);
    if (geminiResult.isLeft()) {
      geminiResult.fold((failure) {
        emit(ChatFailure(failure.message));
      }, (_) {});
      return;
    }

    final response = geminiResult.getOrElse(() => '');
    final assistantMessage = ChatMessage.gemini(response);
    messages.add(assistantMessage);
    await chatRepository.saveMessage(userId, activeChatId, assistantMessage);
    emit(ChatLoaded(
      sessions: sessions,
      messages: messages,
      activeChatId: activeChatId,
    ));
  }
}
