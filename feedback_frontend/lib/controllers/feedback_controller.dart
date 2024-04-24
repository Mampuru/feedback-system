import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/api_service.dart';

class FeedBackController {

  Future<Map<String, dynamic>> submitFeedback(String indicator, String description) async {
    final response = await http.post(
      Uri.parse(feedbackURL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'indicator': indicator,
        'description': description,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to submit feedback');
    }
  }

  Future<Map<String, dynamic>> getFeedback() async {
    final response = await http.get(
      Uri.parse(feedbackURL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch feedback');
    }
  }
}
