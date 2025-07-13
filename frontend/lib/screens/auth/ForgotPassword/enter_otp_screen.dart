import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'reset_password_screen.dart';

class EnterOTPScreen extends StatefulWidget {
  final String email;
  EnterOTPScreen({required this.email});

  @override
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  String otp = "";
  String message = "";

  void verifyOtp() {
    if (otp == "1234") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResetPasswordScreen()),
      );
    } else {
      setState(() {
        message = "Invalid OTP. Please try again.";
      });
    }
  }

  void resendOtp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP has been resent.")),
    );
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
            Text(
              "Enter OTP",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("We sent a 4-digit code to your email."),
            const SizedBox(height: 20),

            // ✅ OTP Input Boxes
            PinCodeTextField(
              appContext: context,
              length: 4,
              onChanged: (value) {
                setState(() => otp = value);
              },
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 60,
                fieldWidth: 50,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.white,
                activeColor: Colors.deepOrange,
                selectedColor: Colors.orange,
                inactiveColor: Colors.grey.shade300,
              ),
              enableActiveFill: true,
              animationType: AnimationType.fade,
            ),

            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(message, style: TextStyle(color: Colors.red)),
              ),
            TextButton(
              onPressed: resendOtp,
              child: Text("Resend OTP"),
            ),
            Image.asset('assets/images/otp.png', height: 250),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Verify OTP"),
              onPressed: verifyOtp,
            ),
          ],
        ),
      ),
    );
  }
}
