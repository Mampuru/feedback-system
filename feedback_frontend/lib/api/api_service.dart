import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5000'; // Update with your API base URL

  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> signUp(username,password,email) async {
    final String apiUrl = 'https://your-api-url.com/user/signup'; // Replace with your API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully signed up
      print('Signed up successfully!');
      Navigator.pop(context); // Navigate back to the previous screen
    } else {
      // Failed to sign up
      print('Failed to sign up. Please try again.');
    }
  }
}
