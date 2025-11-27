import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String rating;

  DetailScreen({
    super.key,
    required this.title,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final int? currentIndex;

    return Scaffold(
  backgroundColor: Color(0xFF0E0E10),
  body: SafeArea(
    child: Column(
      children: [
        SizedBox(height: 20),

        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            image,
            width: 260,
            height: 360,
            fit: BoxFit.cover,
          ),
        ),

        SizedBox(height: 20),

        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 10),

        Text(
          "Rating: $rating",
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 30),
        Text(
          "Detail (Dummy)",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      ],
    ),
  ),
);

  }
}
