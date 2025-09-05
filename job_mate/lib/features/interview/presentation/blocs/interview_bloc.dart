import 'package:flutter_bloc/flutter_bloc.dart';
import 'interview_event.dart';
import 'interview_state.dart';
import '../../domain/entities/interview_message.dart';
import '../../domain/usecases/send_freeform_message.dart';
import '../../domain/usecases/start_freeform_session.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  final StartFreeformSession startFreeformSession;
  final SendFreeformMessage sendFreeformMessage;

  List<InterviewMessage> _messages = [];
  String? _chatId;

  InterviewBloc({
    required this.startFreeformSession,
    required this.sendFreeformMessage,
  }) : super(InterviewInitial()) {
    on<StartInterviewSession>((event, emit) async {
      emit(InterviewLoading());
      final result = await startFreeformSession("freeform");
      result.fold(
        (failure) => emit(InterviewError("Could not start session")),
        (session) {
          _chatId = session.chatId;
          emit(InterviewLoaded(_messages));
        },
      );
    });

    on<SendMessage>((event, emit) async {
      if (_chatId == null) return;
      final result = await sendFreeformMessage(_chatId!, event.message);
      result.fold((failure) => emit(InterviewError("Could not send message")), (
        msg,
      ) {
        _messages = List.from(_messages)..add(msg);
        emit(InterviewLoaded(_messages));
      });
    });
  }
}
