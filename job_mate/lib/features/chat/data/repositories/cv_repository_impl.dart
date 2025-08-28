import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/data/datasources/dummy/dummy_cv_data_source.dart';
import 'package:job_mate/features/chat/domain/entities/cv_feedback.dart';
import 'package:job_mate/features/chat/domain/entities/profile.dart';
import 'package:job_mate/features/chat/domain/repositories/cv_repository.dart';

class CvRepositoryImpl implements CvRepository {
  final DummyCvDataSource dataSource;

  CvRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, CvFeedback>> analyzeCv(Profile profile) async {
    try {
      final feedback = await dataSource.analyzeCv(profile);
      return Right(feedback);
    } catch (e) {
      return Left(ServerFailure('Mock CV repository error: $e'));
    }
  }
}
