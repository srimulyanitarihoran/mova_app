import 'package:flutter/material.dart';
import 'package:mova_app/widgets/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return Scaffold(
      backgroundColor: Color(0xFF0E0E10),
      body: Center(
        child: Text(
          "Home (Dummy)",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: currentIndex,
      ),
    );
  }
}
