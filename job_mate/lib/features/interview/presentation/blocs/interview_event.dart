import 'package:equatable/equatable.dart';

abstract class InterviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartInterviewSession extends InterviewEvent {}

class SendMessage extends InterviewEvent {
  final String message;
  SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadChatHistory extends InterviewEvent {
  final String chatId;
  LoadChatHistory(this.chatId);

  @override
  List<Object?> get props => [chatId];
}
