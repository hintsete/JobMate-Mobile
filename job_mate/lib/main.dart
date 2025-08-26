import 'package:flutter/material.dart';
import 'package:job_mate/features/chat/presentation/pages/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JobMate Chat',
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const ChatScreen(), 
    );
  }
}
