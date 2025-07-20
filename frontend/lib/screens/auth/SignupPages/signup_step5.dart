import 'package:flutter/material.dart';

class SignupStep5 extends StatefulWidget {
  @override
  _SignupStep5State createState() => _SignupStep5State();
}

class _SignupStep5State extends State<SignupStep5> {
  final Color orange = const Color(0xFFFF4400);
  final Color background = const Color(0xFFFFF7F2);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? errorMsg;

  void _submit() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    setState(() => errorMsg = null); // Reset error

    if (!_formKey.currentState!.validate()) return;

    if (password != confirmPassword) {
      setState(() => errorMsg = "Passwords do not match.");
    } else if (!isStrongPassword(password)) {
      setState(() => errorMsg =
          "Password must be at least 8 characters and include uppercase, lowercase, digit, and special character.");
    } else if (!_agreeToTerms) {
      setState(() => errorMsg = "You must agree to the Terms and Conditions.");
    } else {
      Navigator.pushNamed(context, '/signupSuccess'); // Navigate on success
    }
  }

  bool isStrongPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  Widget _buildDot(int index, bool isActive) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/signupStep1');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/signupStep2');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/signupStep3');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/signupStep4');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/signupStep5');
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: isActive ? orange : Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back & Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 12),

              // Progress Dots with click navigation
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) => _buildDot(index, index == 4)), // 4 for step 5
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                "Set your password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Create a secure password to protect your account.",
                style: TextStyle(color: Colors.grey[600]),
              ),

              const SizedBox(height: 24),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Enter a password';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Confirm your password';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Terms Checkbox
                    CheckboxListTile(
                      value: _agreeToTerms,
                      onChanged: (value) => setState(() => _agreeToTerms = value!),
                      title: const Text(
                        "I agree to the Terms and Conditions",
                        style: TextStyle(fontSize: 14),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),

              if (errorMsg != null) ...[
                const SizedBox(height: 8),
                Text(
                  errorMsg!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ],

              const SizedBox(height: 24),

              // Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Register", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
