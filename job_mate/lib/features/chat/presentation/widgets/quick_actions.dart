import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final Function(String) onActionSelected;

  const QuickActions({super.key, required this.onActionSelected});

  @override
  Widget build(BuildContext context) {
    final actions = ["CV", "Jobs", "Interview", "Skills"];

    IconData _getIcon(String action) {
      switch (action) {
        case "CV":
          return Icons.article;
        case "Jobs":
          return Icons.work;
        case "Interview":
          return Icons.mic;
        case "Skills":
          return Icons.school;
        default:
          return Icons.circle;
      }
    }

    return Container(
      color: const Color(0xFFEAF6F4),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              actions.map((action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton.icon(
                    onPressed: () => onActionSelected(action),
                    icon: Icon(_getIcon(action), size: 16, color: Colors.black),
                    label: Text(action),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
