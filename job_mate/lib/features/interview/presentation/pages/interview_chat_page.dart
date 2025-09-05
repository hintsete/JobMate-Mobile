import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/interview_bloc.dart';
import '../blocs/interview_event.dart';
import '../blocs/interview_state.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/message_input.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/chat_header.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({super.key});

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  final TextEditingController _controller = TextEditingController();
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    context.read<InterviewBloc>().add(StartInterviewSession());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatHeader(
        onBack: () => Navigator.pop(context),
        onToggleLanguage: () {},
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<InterviewBloc, InterviewState>(
              builder: (context, state) {
                if (state is InterviewLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InterviewLoaded) {
                  return ListView.builder(
                    reverse: false,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(message: state.messages[index]);
                    },
                  );
                }
                return const Center(
                  child: Text("Start your interview practice"),
                );
              },
            ),
          ),
          MessageInput(
            controller: _controller,
            onSend: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty) {
                context.read<InterviewBloc>().add(SendMessage(text));
                _controller.clear();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          // TODO: use go_router navigation here
        },
      ),
    );
  }
}
