import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  Future<void> _sendPasswordResetEmail(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Show success alert
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Email Sent'),
            content: const Text('Check your inbox for the password reset email.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Show error alert
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Error: ${error.toString()}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
@override
Widget build(BuildContext context) {
  String email = ''; // Variable to store the entered email

  return Scaffold(
    appBar: AppBar(
      title: const Text('Forgot Password'),
    ),
    body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/forget.png', // Replace with the path to your image asset
                  height: 240,
                  width: 240, // Adjust the height as needed
                ),
                const SizedBox(height: 10),
                const Text('Forgot your password?'),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    email = value.trim();
                  },
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (email.isNotEmpty) {
                      // Implement logic to send password reset email
                      _sendPasswordResetEmail(context, email);
                    } else {
                      // Show an alert if email is empty
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please enter your email.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Send Reset Email'),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/background.png', // Replace with your image asset
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    ),
  );
}
}