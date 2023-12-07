import 'package:flutter/material.dart';
import 'package:ahmedfoued/service/fake_api_service.dart'; // Add this import

class EditFakePage extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditFakePage({super.key, required this.item});

  @override
  // ignore: library_private_types_in_public_api
  _EditFakePageState createState() => _EditFakePageState();
}

class _EditFakePageState extends State<EditFakePage> {
  final TextEditingController _titleController = TextEditingController();
  final  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.item['title'];
    _bodyController.text = widget.item['body'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Fake Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                _updateItem(context);
              },
              child: const Text('Update Item'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateItem(BuildContext context) {
    final updatedData = {
      'id': widget.item['id'],
      'title': _titleController.text,
      'body': _bodyController.text,
      'userId': widget.item['userId'],
    };
    
    // Remove the 'const' keyword when creating a new instance
    FakeApiService fakeApiService = FakeApiService();
    
    fakeApiService.updateFakeData(updatedData).then((updatedItem) {
      // Handle success scenario, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item updated successfully.'),
        ),
      );
      // You may choose to navigate back or perform any other action
    }).catchError((error) {
      // Handle error scenario, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update item. Error: $error'),
        ),
      );
    });
  }
}
