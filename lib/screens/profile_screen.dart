import 'package:flutter/material.dart';
import 'package:mova_app/widgets/bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 4;

    return Scaffold(
      backgroundColor: Color(0xFF0E0E10),
      body: Center(
        child: Text(
          "Profile (Dummy)",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: currentIndex,
      ),
    );
  }
}
