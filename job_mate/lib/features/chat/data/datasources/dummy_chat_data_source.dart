import 'package:job_mate/features/chat/data/models/message_model.dart';

class DummyChatDataSource {
  Future<MessageModel> sendMessage(String text,int userId) async{
    await Future.delayed(const Duration(milliseconds: 500));
    String mockResponse;

    if(text.toLowerCase().contains('cv')){
      mockResponse='Cool! Tell me about your education or skills';

    }else if(text.toLowerCase().contains('job')){
      mockResponse='You might want to check out ethiojobs.net or Upwork for entry-level opportunities.';

    } else if (text.toLowerCase().contains("interview")) {
        mockResponse = "Common question: Tell me about yourself. Try to keep it under 2 minutes.";
    } else if (text.toLowerCase().contains("skills")) {
        mockResponse = "In-demand skills: problem solving, communication, and tech tools like Excel or Python.";
    } else if (text.startsWith("Analyze CV:")) {
        mockResponse = "1. Great start with your skills! 2. Add project details. 3. Try ethiojobs.net for internships.";
    } else {
        mockResponse = "Hello from JobMate! How can I help?";
    }
    return MessageModel(conversationId: DateTime.now().millisecondsSinceEpoch, userId: 0, message: mockResponse, isFromUser: false, createdAt: DateTime.now());
  }
}