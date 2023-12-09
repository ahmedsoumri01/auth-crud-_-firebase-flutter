import 'package:ahmedfoued/dashboard_page.dart';
import 'package:ahmedfoued/home_page.dart';
import 'package:flutter/material.dart';
import 'auth/forgot_password_page.dart'; // Import the new page
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth/login.dart';
import 'auth/signup.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) =>  SignupPage(),
        '/dashboard': (context) =>   DashboardPage(), // Add the dashboard route
              '/forgot_password': (context) => const ForgotPasswordPage(), // Add the route for the new page
      },
    );
  }
}


