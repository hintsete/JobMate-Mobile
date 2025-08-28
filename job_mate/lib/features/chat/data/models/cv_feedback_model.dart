import 'package:job_mate/features/chat/domain/entities/cv_feedback.dart';

class CvFeedbackModel extends CvFeedback {
  const CvFeedbackModel({
    required super.sessionId,
    required super.cvId,
    required super.userId,
    required super.strengths,
    required super.weaknessess,
    required super.improvementSuggestions,
    required super.generatedAt,
  });
}