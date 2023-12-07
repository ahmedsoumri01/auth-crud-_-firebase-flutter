import 'package:flutter/material.dart';
import 'package:ahmedfoued/service/auth_service.dart'; // Import your AuthService
import 'fake_api/fake_api_page.dart';
import 'fire_crud/fire_crud_page.dart';

class DashboardPage extends StatelessWidget {
  final AuthService authService = AuthService();

   DashboardPage({super.key});

  Future<void> _logout(BuildContext context) async {
    await authService.signOut();
    // Navigate back to the login page
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FakeApiPage()));
              },
              child: const Text('Use Fake API'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FireCrudPage()));
              },
              child: const Text('Use Firebase CRUD'),
            ),
          ],
        ),
      ),
    );
  }
}
