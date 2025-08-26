import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../widgets/chat_header.dart';
import '../widgets/quick_actions.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user-1');

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toIso8601String(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });
  }

  void _handleQuickAction(String action) {
    _handleSendPressed(types.PartialText(text: action));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatHeader(
        onBack: () => Navigator.pop(context),
        onToggleLanguage: () {
          // TODO: implement language switch logic
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
              theme: const DefaultChatTheme(
                primaryColor: Color(0xFF1B7F79),
                sentMessageBodyTextStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          QuickActions(onActionSelected: _handleQuickAction),
        ],
      ),
    );
  }
}
