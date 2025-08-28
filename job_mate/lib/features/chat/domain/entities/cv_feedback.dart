import 'package:equatable/equatable.dart';

class CvFeedback extends Equatable{
  final int sessionId;
  final int cvId;
  final int userId;
  final String strengths;
  final String weaknessess;
  final String improvementSuggestions;
  final DateTime generatedAt;

  const CvFeedback({
    required this.sessionId,
    required this.userId,
    required this.cvId,
    required this.strengths,
    required this.weaknessess,
    required this.improvementSuggestions,
    required this.generatedAt,
  });


  @override
 
  List<Object?> get props => [sessionId,cvId,userId,strengths,weaknessess,improvementSuggestions,generatedAt];}