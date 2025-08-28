import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:job_mate/core/error/failure.dart';
import 'package:job_mate/features/chat/domain/entities/cv_feedback.dart';
import 'package:job_mate/features/chat/domain/usecases/get_cv_advice.dart';


part 'cv_event.dart';
part 'cv_state.dart';

class CvBloc extends Bloc<CvEvent, CvState> {
  final GetCvAdvice getCvAdvice;
  CvBloc({required this.getCvAdvice}) : super(CvInitial()) {
    on<AnalyzeCv>((event, emit) async{
      emit(CvLoading());
      try{
        final Either<Failure,CvFeedback> result= await getCvAdvice(event.text,event.userId);
        result.fold(
          (failure)=> emit(CvError(failure.message)), 
          (feedback)=> emit(FeedbackRecived(feedback)));

      }catch(e){
        emit(CvError(e.toString()));

      }
      
    });
  }
}
