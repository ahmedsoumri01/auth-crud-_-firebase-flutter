import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class FakeApiService {
  Future<List<Map<String, dynamic>>> getFakeData() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load fake data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load fake data: $error');
    }
  }

  Future<void> deleteFakeData(int postId) async {
    try {
      final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete fake data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to delete fake data: $error');
    }
  }

  Future<Map<String, dynamic>> updateFakeData(Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${updatedData['id']}'),
        body: json.encode(updatedData),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update fake data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update fake data: $error');
    }
  }

  Future<void> addNewPost(Map<String, dynamic> postData) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: json.encode(postData),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception('Failed to add a new post. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to add a new post: $error');
    }
  }
}
