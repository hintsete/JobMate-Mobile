part of 'cv_bloc.dart';

abstract class CvState extends Equatable {
  const CvState();
  @override
  
  List<Object?> get props => [];
}

final class CvInitial extends CvState {

}

final class CvLoading extends CvState{

}

final class FeedbackRecived extends CvState{
  final CvFeedback feedback;
  const FeedbackRecived(this.feedback);
  @override
  
  List<Object?> get props => [feedback];

}
final class CvError extends CvState{
  final String error;
  const CvError(this.error);
  @override
  
  List<Object?> get props => [error];
}