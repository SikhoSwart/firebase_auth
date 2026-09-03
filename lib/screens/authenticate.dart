import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  // By default, show the Login screen first
  bool showSignIn = true;

  // Function to toggle the state
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      // Pass the toggle function down to LoginScreen
      return LoginScreen(onToggleToRegister: toggleView);
    } else {
      // Pass the toggle function down to RegisterScreen
      return RegisterScreen(onToggleToLogin: toggleView);
    }
  }
}