import 'package:flutter/material.dart';
import 'package:job_mate/features/chat/data/datasources/dummy/dummy_chat_data_source.dart';
import 'package:job_mate/features/chat/data/repositories/chat_repository_impl.dart';



import 'package:job_mate/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:job_mate/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:job_mate/features/chat/presentation/pages/chat_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final chatRepository = ChatRepositoryImpl(DummyChatDataSource());
    // after implementing the data layer turn of the comment below
    // final CvRepository=CvRepositoryImpl(DummyChatDataSource());
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobMate Chat',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: BlocProvider(
        create: (context) => ChatBloc(
          sendChatMessage: SendMessageUsecase(chatRepository),
          // getCvAdvice: GetCvAdvice(repository),
        ),
        child: ChatScreen(),
      ),
    );
  }
}