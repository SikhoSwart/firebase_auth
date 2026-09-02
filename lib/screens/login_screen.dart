import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onToggleToRegister;

  const LoginScreen({super.key, this.onToggleToRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Text controllers for capturing input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Handle Login Logic
  Future<void> _handleLogin() async {
    // validate Form Fields
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Call AuthService (StreamBuilder in Wrapper handles routing on success)
      await _authService.signInWithEmail(
        _emailController.text,
        _passwordController.text,
      );
    } catch (errorMessage) {
      // Show SnackBar Error on failure
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage.toString()),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      // reset loading state if screen is still mounted
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

}