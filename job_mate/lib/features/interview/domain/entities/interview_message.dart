import 'package:equatable/equatable.dart';

enum InterviewSender { user, assistant }

class InterviewMessage extends Equatable {
  final String chatId;
  final InterviewSender sender;
  final String text;
  final DateTime timestamp;
  final String? id;

  const InterviewMessage({
    required this.chatId,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.id,
  });

  @override
  List<Object?> get props => [chatId, sender, text, timestamp, id];
}


