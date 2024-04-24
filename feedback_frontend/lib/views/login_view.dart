import 'package:feedback_frontend/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:feedback_frontend/views/feedback_view.dart';
import 'package:feedback_frontend/views/signup_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserController _userController = UserController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SizedBox(
          width: 400.0, // Fixed width for the Card
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const FeedbackView()),
                      );
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SignUpView()),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
