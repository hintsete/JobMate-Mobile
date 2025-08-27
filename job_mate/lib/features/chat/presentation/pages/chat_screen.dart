import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        builder: (ctx) => AlertDialog(
          title: const Text('Enter CV Summary'),
          content: TextField(
            controller: cvController,
            decoration: const InputDecoration(hintText: 'E.g., CS degree, built app'),
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
                  BlocProvider.of<ChatBloc>(context).add(RequestCvAdvice('Analyze CV: $text', 1));
                  Navigator.of(ctx).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: ChatHeader(
          onBack: () => Navigator.pop(context),
          onToggleLanguage: () {
            // TODO: Implement Amharic/English toggle (e.g., google_fonts)
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
                    reverse: true, // Newest messages at bottom
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[state.messages.length - 1 - index]; // Reverse order
                      return Align(
                        alignment: message.isFromUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: message.isFromUser ? const Color(0xFF2196F3) : const Color(0xFF009688),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!message.isFromUser)
                                const Icon(Icons.handshake, size: 20, color: Colors.white),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  message.message,
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
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
                  BlocProvider.of<ChatBloc>(context).add(const SendMessage('I need help with my CV', 1));
                  Future.delayed(const Duration(milliseconds: 500), () => _showCvInputDialog(context));
                } else {
                  BlocProvider.of<ChatBloc>(context).add(SendMessage(action, 1));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          BlocProvider.of<ChatBloc>(context).add(SendMessage(text, 1));
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final text = _controller.text;
                      if (text.isNotEmpty) {
                        BlocProvider.of<ChatBloc>(context).add(SendMessage(text, 1));
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }