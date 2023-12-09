import 'package:flutter/material.dart';
import 'package:ahmedfoued/service/auth_service.dart';

class SignupPage extends StatelessWidget {
  final AuthService authService = AuthService();
  String email = '';
  String password = '';
  String confirmPassword = '';

  SignupPage({super.key});

  Future<void> _signUp(BuildContext context) async {
    // Check if email and password are not empty
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showAlert(context, 'All fields must be filled');
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      _showAlert(context, 'Passwords do not match');
      return;
    }

    // Perform signup
    final result = await authService.signUpWithEmailAndPassword(email, password);

    if (result == null) {
      // Successful registration, navigate to the login page
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Handle registration failure (show an error message)
      _showAlert(context, result);
    }
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    "Create an account, It's free",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  makeInput(label: "Email", onChanged: (value) => email = value.trim()),
                  makeInput(label: "Password", obscureText: true, onChanged: (value) => password = value.trim()),
                  makeInput(label: "Confirm Password", obscureText: true, onChanged: (value) => confirmPassword = value.trim()),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: const Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    _signUp(context);
                  },
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      " Login",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget makeInput({label, obscureText = false, void Function(String)? onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(height: 5,),
      TextField(
        onChanged: (value) {
          if (obscureText) {
            onChanged?.call(value); // Call onChanged with the password value
          } else {
            onChanged?.call(""); // Clear the text field
          }
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          suffixIcon: obscureText
              ? IconButton(
                  onPressed: () {
                    onChanged?.call(""); // Clear the text field
                  },
                  icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                )
              : null,
        ),
      ),
      const SizedBox(height: 30,),
    ],
  );
}

}
