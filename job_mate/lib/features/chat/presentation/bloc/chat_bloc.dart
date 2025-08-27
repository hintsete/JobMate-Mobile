import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/domain/entities/message.dart';
import 'package:job_mate/features/chat/domain/usecases/get_cv_advice.dart';
import 'package:job_mate/features/chat/domain/usecases/send_message_usecase.dart';

// import 'package:job_mate/features/chat/presentation/bloc/chat_state.dart';


part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
    final SendMessageUsecase sendChatMessage;
    final GetCvAdvice getCvAdvice;

    ChatBloc({
      required this.sendChatMessage,
      required this.getCvAdvice,
    }) : super(ChatInitial()) {
      on<SendMessage>((event, emit) async {
        emit(ChatLoading(state.messages));
        try {
          final userMessage = Message(
            conversationId: DateTime.now().millisecondsSinceEpoch,
            userId: event.userId,
            message: event.text,
            isFromUser: true,
            createdAt: DateTime.now(),
          );
          final messages = [...state.messages, userMessage];
          emit(ChatMessageSent(messages));
          final Either<Failure, Message> result = await sendChatMessage(event.text, event.userId);
          result.fold(
            (failure) => emit(ChatError(failure.message, messages)),
            (aiMessage) => emit(ChatMessageSent([...messages, aiMessage])),
          );
        } catch (e) {
          emit(ChatError(e.toString(), state.messages));
        }
      });

      on<RequestCvAdvice>((event, emit) async {
        emit(ChatLoading(state.messages));
        try {
          final Either<Failure, Message> result = await getCvAdvice(event.profileText, event.userId);
          result.fold(
            (failure) => emit(ChatError(failure.message, state.messages)),
            (aiMessage) => emit(ChatMessageSent([...state.messages, aiMessage])),
          );
        } catch (e) {
          emit(ChatError(e.toString(), state.messages));
        }
      });
    }
  }
