import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/domain/entities/cv_feedback.dart';
import 'package:job_mate/features/chat/domain/entities/profile.dart';

abstract class CvRepository {
  Future<Either<Failure,CvFeedback>>  analyzeCv(Profile profile);
}