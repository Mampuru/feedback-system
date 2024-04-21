import 'package:flutter/material.dart';

import '../models/feedback_model.dart';

class AdminFeedbackView extends StatefulWidget {
  @override
  _AdminFeedbackViewState createState() => _AdminFeedbackViewState();
}

class _AdminFeedbackViewState extends State<AdminFeedbackView> {
  late List<FeedbackModel> feedbacks;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Feedback'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Feedback',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: feedbacks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(feedbacks[index].indicator),
                    subtitle: Text(feedbacks[index].description),
                    // You can add more actions here, e.g., delete feedback
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

