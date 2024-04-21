import 'package:flutter/material.dart';
import '../api/api_service.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final ApiService _apiService = ApiService();
  String _selectedIndicator = 'Success'; // Default selected indicator
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _indicators = ['Success', 'Failure', 'Bad']; // Dropdown items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedIndicator,
              items: _indicators.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedIndicator = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Indicator',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await _apiService.submitFeedback(
                    _selectedIndicator,
                    _descriptionController.text,
                  );
                  _descriptionController.clear();
                  // Navigate to respective dashboard
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Feedback submitted successfully!'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}