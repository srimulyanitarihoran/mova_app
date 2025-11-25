import 'package:flutter/material.dart';
import 'screens/explore_screen.dart';

void main() {
  runApp(const MovaApp());
}

class MovaApp extends StatelessWidget {
  const MovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0E0E10),
        useMaterial3: true
      ),
      home: ExploreScreen(),
    );
  }
}
