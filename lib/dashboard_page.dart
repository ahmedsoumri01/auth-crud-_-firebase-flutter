import 'package:flutter/material.dart';
import 'package:ahmedfoued/service/auth_service.dart';
import 'fake_api/fake_api_page.dart';
import 'fire_crud/fire_crud_page.dart';

class DashboardPage extends StatelessWidget {
  final AuthService authService = AuthService();

  DashboardPage({Key? key});

  Future<void> _logout(BuildContext context) async {
    await authService.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final String? userEmail = authService.getCurrentUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard',
        textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Use Fake API'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FakeApiPage()));
              },
            ),
            ListTile(
              title: const Text('Use Firebase CRUD'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FireCrudPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
             userEmail != null ? 'Welcome, $userEmail' : 'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Add more widgets/content as needed
          ],
        ),
      ),
    );
  }
}
