import 'package:flutter/material.dart';
import 'screens/auth/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/SignupPages/signup_step1.dart';
import 'screens/auth/SignupPages/signup_step2.dart';
import 'screens/auth/SignupPages/signup_step3.dart';
import 'screens/auth/ForgotPassword/forgot_password_screen.dart';
import 'screens/auth/ForgotPassword/enter_otp_screen.dart';
import 'screens/auth/ForgotPassword/reset_password_screen.dart';
import 'screens/auth/ForgotPassword/password_reset_success_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TalentCast',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Color(0xFFFFFCF9),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>  OnboardingScreen(),
        '/login': (context) =>  LoginScreen(),
        '/signup-step1': (context) =>  SignupStep1(),
        '/signup-step2': (context) =>  SignupStep2(),
        '/signup-step3': (context) =>  SignupStep3(),
        '/forgot-password': (context) =>  ForgotPasswordScreen(),
        '/enter-otp': (context) =>  EnterOTPScreen(email: ''),
        '/reset-password': (context) => ResetPasswordScreen(),
        '/reset-success': (context) => PasswordResetSuccessScreen(),
        // Add more routes like dashboard, home, etc. later
      },
    );
  }
}
