import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/interview/domain/entities/interview_message.dart';
import 'package:job_mate/features/interview/domain/entities/interview_session.dart';

abstract class InterviewRepository {
  Future<Either<Failure, InterviewSession>> startFreeformSession(String sessionType);
  Future<Either<Failure, InterviewMessage>> sendFreeformMessage(String chatId, String message);
  Future<Either<Failure, List<InterviewMessage>>> getFreeformHistory(String chatId);
}


