import 'package:dartz/dartz.dart';
import 'package:test_ai/core/error/failure.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<Either<Failure, String>> call(String message) async {
    return await repository.getGeminiResponse(message);
  }
}