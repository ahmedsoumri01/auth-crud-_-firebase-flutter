import 'package:flutter/material.dart';
import 'package:ahmedfoued/service/fake_api_service.dart';
import 'edit_fake_page.dart';
import 'add_post_page.dart'; // Import the AddPostPage

class FakeApiPage extends StatefulWidget {
  const FakeApiPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FakeApiPageState createState() => _FakeApiPageState();
}
class _FakeApiPageState extends State<FakeApiPage> {
  final FakeApiService _fakeApiService = FakeApiService();
  late Future<List<Map<String, dynamic>>> _fakeData;
  TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fakeData = _fakeApiService.getFakeData(userId: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake API Page'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _userIdController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter User ID',
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _filterPosts();
                },
                child: const Text('Filter'),
              ),
              TextButton(
  onPressed: () {
    _cancelFilter();
  },
      style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red), // Border color
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.red)),
                    ),

            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fakeData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No data available.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return ListTile(
                        title: Text(item['title']),
                        onTap: () {
                          _showItemDetails(context, item);
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _confirmDeleteItem(context, item);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _navigateToEditFakePage(context, item);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewPost(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showItemDetails(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Item Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${item['title']}'),
              Text('Body: ${item['body']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteItem(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(context, item);
                Navigator.pop(context); // Close the confirmation dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _addNewPost(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPostPage(),
      ),
    );
  }

  void _deleteItem(BuildContext context, Map<String, dynamic> item) {
    _fakeApiService.deleteFakeData(item['id']).then((_) {
      // Reload data after deletion if necessary
      setState(() {
        _fakeData = _fakeApiService.getFakeData(userId: null);
      });
      // Show a message indicating successful deletion
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item deleted successfully.'),
        ),
      );
    }).catchError((error) {
      // Handle deletion error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete item. Error: $error'),
        ),
      );
    });
  }

  void _navigateToEditFakePage(BuildContext context, Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFakePage(item: item),
      ),
    );
  }

void _filterPosts() {
    final userId = int.tryParse(_userIdController.text);
    if (userId != null) {
      setState(() {
        _fakeData = _fakeApiService.getPostsByUserId(userId);
      });
    } else {
      // Show an error message if the entered value is not a valid integer
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid User ID.'),
        ),
      );
    }
  }

  void _cancelFilter() {
    // Reset to the original data without filtering
    setState(() {
      _fakeData = _fakeApiService.getFakeData(userId: null);
      _userIdController.text = ''; // Clear the text field
    });
  }


}
