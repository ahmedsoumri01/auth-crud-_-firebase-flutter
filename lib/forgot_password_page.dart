// forgot_password_page.dart
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Forgot your password?'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to send a password reset email
              },
              child: const Text('Send Reset Email'),
            ),
          ],
        ),
      ),
    );
  }
}
