import 'package:feedback_frontend/views/feedback_view.dart';
import 'package:feedback_frontend/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                // try {
                //   final response = await _apiService.loginUser(
                //     _usernameController.text,
                //     _passwordController.text,
                //   );
                //   // Save token to shared preferences
                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                //   prefs.setString('token', response['token']);
                //   // Navigate to respective dashboard
                // } catch (e) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Login failed')),
                //   );
                // }
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FeedbackView()));

              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpView()));
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
