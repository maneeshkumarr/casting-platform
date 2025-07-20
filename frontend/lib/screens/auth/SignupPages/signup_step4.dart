import 'package:flutter/material.dart';
import 'signup_step5.dart';

class SignupStep4 extends StatelessWidget {
  final Color orange = Color(0xFFFF4400);
  final Color background = Color(0xFFFFF7F2); // soft beige background
  final List<String> imagePlaceholders = [
    'assets/photo1.png',
    'assets/photo2.png',
    'assets/photo3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back arrow and title
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Spacer(flex: 2),
                ],
              ),

              SizedBox(height: 12),

              // Progress Dots
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) => _buildDot(index == 3)),
                ),
              ),

              SizedBox(height: 32),

              Text(
                "Upload your photos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "Upload recent headshots or portfolio photos",
                style: TextStyle(color: Colors.grey[600]),
              ),

              SizedBox(height: 32),

              // 3 image upload boxes
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: List.generate(imagePlaceholders.length, (index) {
                    return _buildImageBox(imagePlaceholders[index]);
                  }),
                ),
              ),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: add upload validation
                    Navigator.pushNamed(context, '/signupStep5');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("Next", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? orange : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildImageBox(String assetPath) {
    return GestureDetector(
      onTap: () {
        // TODO: Handle image picker
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
