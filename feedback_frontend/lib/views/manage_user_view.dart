import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ManageUsersView extends StatefulWidget {
  const ManageUsersView({super.key});

  @override
  _ManageUsersViewState createState() => _ManageUsersViewState();
}

class _ManageUsersViewState extends State<ManageUsersView> {
  late List<User> users;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Implement functionality to add new user
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Users',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index].email),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Implement edit functionality
                      },
                    ),
                    // You can add more actions here, e.g., delete user
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
