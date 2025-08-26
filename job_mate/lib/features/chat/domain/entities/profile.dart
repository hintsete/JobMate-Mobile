import 'package:equatable/equatable.dart';

class Profile extends Equatable{
  final int cvId;
  final int userId;
  final String originalText;
  final String language;


  const Profile({
    required this.cvId,
    required this.userId,
    required this.originalText,
    this.language='en',
   
  });
  
  @override
  
  List<Object?> get props => [cvId,userId,originalText,language];

}
