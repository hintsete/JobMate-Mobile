import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final Function(String) onActionSelected;

  const QuickActions({super.key, required this.onActionSelected});

  @override
  Widget build(BuildContext context) {
    final actions = ["CV", "Jobs", "Interview", "Skills"];

    return Container(
      color: const Color.fromARGB(255, 191, 244, 234), 
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: actions.map((action) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton.icon(
                onPressed: () => onActionSelected(action),
                icon: const Icon(Icons.insert_drive_file, size: 16),
                label: Text(action),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
