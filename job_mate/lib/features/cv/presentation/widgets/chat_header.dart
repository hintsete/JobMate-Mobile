import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:job_mate/core/presentation/widgets/language_toggle_button.dart';

class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  final VoidCallback onShowHistory;

  const ChatHeader({
    super.key,
    required this.onBack,
    required this.onShowHistory,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      backgroundColor: const Color(0xFFEAF6F4),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBack,
      ),
      title: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF005148),
            child: Text("JM", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.appTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                l10n.yourAiCareerBuddy,
                style: const TextStyle(fontSize: 12, color: Color(0xFF1E1E1E)),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history, color: Colors.black),
          onPressed: onShowHistory,
        ),
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: LanguageToggleButton(
            backgroundColor: Colors.white,
            iconColor: Colors.black,
            textColor: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
