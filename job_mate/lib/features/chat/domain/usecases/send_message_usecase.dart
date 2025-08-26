import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/domain/entities/message.dart';
import 'package:job_mate/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUsecase {
  final ChatRepository repository;

  SendMessageUsecase(this.repository);

  Future<Either<Failure,Message>> call(String text, int userId) async{
    return await repository.sendMessage(text, userId);
  }




}