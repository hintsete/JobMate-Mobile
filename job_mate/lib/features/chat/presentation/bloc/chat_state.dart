part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
    final List<Message> messages;
    const ChatState(this.messages);
    @override
    List<Object> get props => [messages];
  }

  class ChatInitial extends ChatState {
    const ChatInitial() : super(const []);
  }

  class ChatLoading extends ChatState {
    const ChatLoading(super.messages);
  }

  class ChatMessageSent extends ChatState {
    const ChatMessageSent(super.messages);
  }

  class ChatError extends ChatState {
    final String error;
    const ChatError(this.error, super.messages);
    @override
    List<Object> get props => [error, messages];
  }
