import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:test_ai/core/error/custom_exception.dart';
import 'package:test_ai/core/error/failure.dart';
import 'package:test_ai/core/services/database_service.dart';
import 'package:test_ai/features/chat/data/models/chat_message.dart';
import 'package:test_ai/features/chat/data/models/chat_session_model.dart';

import '../../domain/repositories/chat_repository.dart';
import '../datasources/gemini_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GeminiRemoteDataSource remoteDataSource;
  final DatabaseService databaseService;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.databaseService,
  });

  @override
  Future<Either<Failure, String>> getGeminiResponse(String message) async {
    try {
      final response = await remoteDataSource.sendMessageToGemini(message);
      return Right(response);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      String m = e.toString();
      debugPrint('gemini error: $m');
      return Left(ServerFailure('حدث خطأ غير متوقع في معالجة البيانات'));
    }
  }

  @override
  Future<Either<Failure, List<ChatSessionModel>>> getChatSessions(
    String userId,
  ) async {
    try {
      final raw = await databaseService.getData(
        path: 'users/$userId/chats',
        query: {'orderBy': 'createdAt', 'descending': true},
      );
      final sessions = (raw as List)
          .map((item) => ChatSessionModel.fromMap(item as Map<String, dynamic>))
          .toList();
      return Right(sessions);
    } catch (e) {
      return Left(
        ServerFailure('Unable to load chat sessions from Firestore.'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> getChatMessages(
    String userId,
    String chatId,
  ) async {
    try {
      final raw = await databaseService.getData(
        path: 'users/$userId/chats/$chatId/messages',
        query: {'orderBy': 'createdAt', 'descending': false},
      );
      final messages = (raw as List)
          .map((item) => ChatMessage.fromMap(item as Map<String, dynamic>))
          .toList();
      return Right(messages);
    } catch (e) {
      return Left(ServerFailure('Unable to load chat history from Firestore.'));
    }
  }

  @override
  Future<Either<Failure, void>> saveMessage(
    String userId,
    String chatId,
    ChatMessage message,
  ) async {
    try {
      await databaseService.addData(
        path: 'users/$userId/chats/$chatId/messages',
        data: message.toMap(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Unable to save chat message to Firestore.'));
    }
  }

  @override
  Future<Either<Failure, ChatSessionModel>> createChatSession(
    String userId,
    String title,
  ) async {
    try {
      final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
      final session = ChatSessionModel(
        id: sessionId,
        title: title,
        createdAt: DateTime.now().toIso8601String(),
      );
      await databaseService.addData(
        path: 'users/$userId/chats',
        documentId: sessionId,
        data: session.toMap(),
      );
      return Right(session);
    } catch (e) {
      return Left(ServerFailure('Unable to create chat session in Firestore.'));
    }
  }
}
