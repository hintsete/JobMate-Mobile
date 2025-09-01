import 'package:equatable/equatable.dart';

class Message extends Equatable{
    final int conversationId;
    final int userId;
    final String message;
    final bool isFromUser;
    final DateTime createdAt;

    const Message({
        required this.conversationId,
        required this.userId,
        required this.message,
        required this.isFromUser,
        required this.createdAt,
    });
    
      @override
      
      List<Object?> get props => [conversationId,userId,message,isFromUser,createdAt];


}