import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure,Message>> sendMessage(String text, int userId);
}