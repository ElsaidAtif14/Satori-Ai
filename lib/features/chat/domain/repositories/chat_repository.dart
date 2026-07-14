import 'package:dartz/dartz.dart';
import 'package:test_ai/core/error/failure.dart';
import 'package:test_ai/features/chat/data/models/chat_message.dart';
import 'package:test_ai/features/chat/data/models/chat_session_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, String>> getGeminiResponse(String message);
  Future<Either<Failure, List<ChatSessionModel>>> getChatSessions(
    String userId,
  );
  Future<Either<Failure, List<ChatMessage>>> getChatMessages(
    String userId,
    String chatId,
  );
  Future<Either<Failure, void>> saveMessage(
    String userId,
    String chatId,
    ChatMessage message,
  );
  Future<Either<Failure, ChatSessionModel>> createChatSession(
    String userId,
    String title,
  );
}
