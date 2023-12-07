import 'package:flutter/material.dart';
import 'package:ahmedfoued/service/fake_api_service.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final FakeApiService _fakeApiService = FakeApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addNewPost(context);
              },
              child: const Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewPost(BuildContext context) async {
    try {
      // Get the entered data
      String title = _titleController.text;
      String body = _bodyController.text;

      // Call the method to add a new post with the entered data
      await _fakeApiService.addNewPost({'title': title, 'body': body, 'userId': 1});

      // Show a message indicating successful addition
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New post added successfully.'),
        ),
      );

      // Close the add post page
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (error) {
      // Handle error scenario
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add a new post. Error: $error'),
        ),
      );
    }
  }
}
