import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/domain/entities/message.dart';
import 'package:job_mate/features/chat/domain/repositories/chat_repository.dart';

class GetCvAdvice {
  final ChatRepository repository;

  GetCvAdvice(this.repository);
  // send message as a prompt
  Future<Either<Failure,Message>> call(String profileText, int userId) async{
    return await repository.sendMessage('Analyze CV: $profileText', userId);
  }


}