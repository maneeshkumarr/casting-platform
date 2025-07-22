import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'signup_step5.dart';

class SignupStep4 extends StatefulWidget {
  @override
  _SignupStep4State createState() => _SignupStep4State();
}

class _SignupStep4State extends State<SignupStep4> {
  final Color orange = Color(0xFFFF4400);
  final Color background = Color(0xFFFFF7F2); // soft beige background

  final ImagePicker _picker = ImagePicker();

  // Stores picked images
  List<File?> selectedImages = [null, null, null];

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
                  children:
                      List.generate(5, (index) => _buildDot(index == 3)),
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
                  children: List.generate(3, (index) {
                    return _buildImageBox(index);
                  }),
                ),
              ),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    bool allSelected =
                        selectedImages.every((image) => image != null);

                    if (!allSelected) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please upload all 3 images"),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

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

  Widget _buildImageBox(int index) {
    return GestureDetector(
      onTap: () async {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 75,
        );

        if (pickedFile != null) {
          setState(() {
            selectedImages[index] = File(pickedFile.path);
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: selectedImages[index] != null
              ? Image.file(
                  selectedImages[index]!,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.grey, size: 36),
                      SizedBox(height: 8),
                      Text(
                        "Tap to upload",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
