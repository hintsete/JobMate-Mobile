import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/data/datasources/dummy_chat_data_source.dart';
import 'package:job_mate/features/chat/domain/entities/message.dart';
import 'package:job_mate/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final DummyChatDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);
  

  @override
  Future<Either<Failure, Message>> sendMessage(String text, int userId) async {
    try {
      // ignore: unused_local_variable
      final userMessage = Message(
        conversationId: 1,
        userId: userId,
        message: text,
        isFromUser: true,
        createdAt: DateTime.now(),
      );
      final aiMessage=await dataSource.sendMessage(text, userId);
      return Right(aiMessage);
      
    } catch (e) {
      return Left(ServerFailure('Mock repository error: $e'));
    }
  }

  // String _generateMockResponse(String text) {
  //   if (text.toLowerCase().contains("cv")) {
  //     return "Here’s a quick CV tip: highlight your projects and list the technologies you used.";
  //   } else if (text.toLowerCase().contains("job")) {
  //     return "You might want to check out ethiojobs.net or Upwork for entry-level opportunities.";
  //   } else if (text.toLowerCase().contains("interview")) {
  //     return "Common question: Tell me about yourself. Try to keep it under 2 minutes.";
  //   } else if (text.toLowerCase().contains("skills")) {
  //     return "In-demand skills: problem solving, communication, and tech tools like Excel or Python.";
  //   } else {
  //     return "Got it! You said: $text. (This is a mock response)";
  //   }
  // }
}
