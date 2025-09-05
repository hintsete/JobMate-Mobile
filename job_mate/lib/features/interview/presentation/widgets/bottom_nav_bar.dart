import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.description), label: "CV"),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Interview"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Skills"),
      ],
    );
  }
}
