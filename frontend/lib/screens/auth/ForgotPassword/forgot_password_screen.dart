import 'package:flutter/material.dart';
import 'enter_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isValidEmail = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(validateEmail);
  }

  void validateEmail() {
    final email = emailController.text.trim();
    setState(() {
      isValidEmail = email.contains('@') && email.contains('.');
    });
  }

  @override
  void dispose() {
    emailController.removeListener(validateEmail);
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 8),

              // Title
              const Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Center(
                child: Text(
                  "Enter your email to receive a reset code.",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 24),

              // Email Input
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Image
              Center(
                child: Image.asset(
                  'assets/images/forgot_password.png', // Make sure this image exists
                  height: 250,
                ),
              ),

              const Spacer(),

              // Send OTP Button (Always Visible, Conditionally Enabled)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isValidEmail ? Colors.deepOrange : Colors.deepOrange.shade200,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isValidEmail
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EnterOTPScreen(
                              email: emailController.text,
                            ),
                          ),
                        );
                      }
                    : null, // disables the button if invalid
                child: const Text("Send OTP"),
              ),

              const SizedBox(height: 10),

              // Back to Login
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
