import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:job_mate/features/chat/data/datasources/local/profile_local_data_source.dart';
import 'package:job_mate/features/chat/domain/entities/profile.dart';
import 'package:job_mate/features/chat/presentation/bloc/chat_bloc.dart';

import '../widgets/chat_header.dart';
import '../widgets/quick_actions.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ProfileLocalDataSource _profileLocal = ProfileLocalDataSource();

  ChatScreen({super.key});

  void _showCvInputDialog(BuildContext context) {
    final TextEditingController cvController = TextEditingController();
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Enter CV Summary'),
            content: TextField(
              controller: cvController,
              decoration: const InputDecoration(
                hintText: 'E.g., CS degree, built app',
              ),
              maxLines: 5,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final text = cvController.text;
                  if (text.isNotEmpty) {
                    await _profileLocal.saveProfile(
                      Profile(cvId: 1, userId: 1, originalText: text),
                    );
                    BlocProvider.of<ChatBloc>(
                      context,
                    ).add(RequestCvAdvice('Analyze CV: $text', 1));
                    Navigator.of(ctx).pop();
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
    );
  }

  String _formatTimestamp(DateTime time) {
    return DateFormat('hh:mma').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatHeader(
        onBack: () => Navigator.pop(context),
        onToggleLanguage: () {
          // TODO: Implement Amharic/English toggle
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        state.messages[state.messages.length - 1 - index];
                    final isUser = message.isFromUser;
                    final bubbleColor =
                        isUser
                            ? const Color.fromARGB(255, 160, 220, 209)
                            : Color(0xFF009688);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                            isUser
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          if (!isUser) // JobMate icon
                            const CircleAvatar(
                              backgroundColor: Color(0xFF005148),
                              child: Text(
                                "JM",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          if (!isUser) const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: bubbleColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message.message,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _formatTimestamp(DateTime.now()),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isUser) const SizedBox(width: 8),
                          if (isUser) // User icon
                            const CircleAvatar(
                              backgroundColor: Color(0xFF005148),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          QuickActions(
            onActionSelected: (action) {
              if (action == 'CV') {
                BlocProvider.of<ChatBloc>(
                  context,
                ).add(const SendMessage('I need help with my CV', 1));
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () => _showCvInputDialog(context),
                );
              } else {
                BlocProvider.of<ChatBloc>(context).add(SendMessage(action, 1));
              }
            },
          ),
          Container(
            color: const Color(0xFFEAF6F4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF005148),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final text = _controller.text;
                        if (text.isNotEmpty) {
                          BlocProvider.of<ChatBloc>(
                            context,
                          ).add(SendMessage(text, 1));
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
