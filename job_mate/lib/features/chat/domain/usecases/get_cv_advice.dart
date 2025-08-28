import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/domain/entities/cv_feedback.dart';

import 'package:job_mate/features/chat/domain/entities/profile.dart';

import 'package:job_mate/features/chat/domain/repositories/cv_repository.dart';

class GetCvAdvice {
  final CvRepository repository;

  GetCvAdvice(this.repository);
  // send message as a prompt
  Future<Either<Failure, CvFeedback>> call(String text, int userId) async{
    final profile=  Profile(
      cvId: DateTime.now().microsecondsSinceEpoch,
      userId: userId,
      originalText: text,
      language: 'en'

    );
    // return await repository.sendMessage('Analyze CV: $profileText', userId);
    return await repository.analyzeCv(profile);
  }
}