import 'package:job_mate/features/chat/domain/entities/message.dart';

class MessageModel extends Message{
  const MessageModel({
    required super.conversationId, 
    required super.userId, 
    required super.message, 
    required super.isFromUser, 
    required super.createdAt});
  
}