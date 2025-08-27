part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
    const ChatEvent();
    @override
    List<Object> get props => [];
  }

  class SendMessage extends ChatEvent {
    final String text;
    final int userId;
    const SendMessage(this.text, this.userId);
    @override
    List<Object> get props => [text, userId];
  }

  class RequestCvAdvice extends ChatEvent {
    final String profileText;
    final int userId;
    const RequestCvAdvice(this.profileText, this.userId);
    @override
    List<Object> get props => [profileText, userId];
  }