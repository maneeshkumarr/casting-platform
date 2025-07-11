import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32),
        Text(
          "Discover Talent",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            "Find the perfect talent for your project with our extensive database of actors, models, and more.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        SizedBox(height: 16),
        Image.asset(
          "assets/images/page1.jpg", // Put your image here
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
