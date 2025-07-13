import 'package:flutter/material.dart';
import 'password_reset_success_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  String errorMsg = "";

  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool isStrongPassword(String password) {
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigit = RegExp(r'\d').hasMatch(password);
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    return password.length >= 8 &&
        hasUppercase &&
        hasLowercase &&
        hasDigit &&
        hasSpecialChar;
  }

  void resetPassword() {
    String password = passController.text;
    String confirmPassword = confirmPassController.text;

    if (password != confirmPassword) {
      setState(() => errorMsg = "Passwords do not match.");
    } else if (!isStrongPassword(password)) {
      setState(() => errorMsg =
          "Password must be at least 8 characters and include uppercase, lowercase, digit, and special character.");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PasswordResetSuccessScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFCF9),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text("Set New Password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // New Password Field
            TextField(
              controller: passController,
              obscureText: !isNewPasswordVisible,
              decoration: InputDecoration(
                hintText: "New Password",
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: Icon(
                    isNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isNewPasswordVisible = !isNewPasswordVisible;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Confirm Password Field
            TextField(
              controller: confirmPassController,
              obscureText: !isConfirmPasswordVisible,
              decoration: InputDecoration(
                hintText: "Confirm New Password",
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
            ),

            if (errorMsg.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(errorMsg, style: TextStyle(color: Colors.red)),
              ),

            const SizedBox(height: 30),
            Image.asset('assets/images/reset_password.png', height: 250),
            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Reset Password"),
              onPressed: resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
