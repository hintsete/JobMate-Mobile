import 'dart:async';
import 'package:job_mate/features/chat/data/models/cv_feedback_model.dart';
import 'package:job_mate/features/chat/domain/entities/profile.dart';

class DummyCvDataSource {
  Future<CvFeedbackModel> analyzeCv(Profile profile) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return CvFeedbackModel(
      sessionId: DateTime.now().millisecondsSinceEpoch,
      cvId: profile.cvId,
      userId: profile.userId,
      strengths: "Strong academic background, good communication skills.",
      weaknessess:
          "Lacks specific project experience, missing measurable achievements.",
      improvementSuggestions:
          "Add quantified results to work experience, include project details.",
      generatedAt: DateTime.now(),
    );
  }
}
