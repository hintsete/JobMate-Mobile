import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final VoidCallback onToggleLanguage;

  const ChatHeader({
    super.key,
    required this.onBack,
    required this.onToggleLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 191, 244, 234),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBack,
      ),
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text("JM", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("JobMate",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              Text("Your AI Career Buddy",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onToggleLanguage,
          icon: Row(
            children: const [
              Icon(Icons.language, color: Colors.black),
              SizedBox(width: 4),
              Text("አማ", style: TextStyle(color: Colors.black)),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
