import 'dart:convert';
import 'package:feedback_frontend/api/api_service.dart';
import 'package:feedback_frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController{

  Future<Map<String, dynamic>> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(loginURL),
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

  Future<Map<String, dynamic>> signUp(username,password,email) async {
    final response = await http.post(
      Uri.parse(signupURL),
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
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<Map<String, dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse(getAdminURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<Map<String, dynamic>> addUser(User user) async {
    final response = await http.post(
      Uri.parse(addAdminURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
        'password': user.password,
        'email': user.email,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add user');
    }
  }

  Future<Map<String, dynamic>> removeUser(String id) async {
    final response = await http.delete(
      Uri.parse("$delAdminURL/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete user');
    }
  }

  Future<Map<String, dynamic>> updateUser(User user) async {
    final response = await http.put(
      Uri.parse("$updateAdminURL/${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user.username,
        'password': user.password,
        'email': user.email,
        'role': user.role
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update user');
    }
  }
}