part of 'cv_bloc.dart';

abstract class CvEvent extends Equatable{
  const CvEvent();
  @override
 
  List<Object?> get props => [];
}
class AnalyzeCv extends CvEvent{
  final String text;
  final int userId;
  const AnalyzeCv(this.text,this.userId);
  @override
  
  List<Object?> get props => [text,userId];

}