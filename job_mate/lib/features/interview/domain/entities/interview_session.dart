import 'package:equatable/equatable.dart';

class InterviewSession extends Equatable {
  final String chatId;
  final String sessionType;
  final DateTime? createdAt;

  const InterviewSession({
    required this.chatId,
    required this.sessionType,
    this.createdAt,
  });

  @override
  List<Object?> get props => [chatId, sessionType, createdAt];
}


