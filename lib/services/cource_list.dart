// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/cource.dart';

class ApiService {
  final String apiUrl = "https://your-backend-api.com/courses"; // Backend URL

  Future<VideoCourse> fetchCourseDetails() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Agar muvaffaqiyatli bo'lsa, JSONni modelga aylantiramiz
      return VideoCourse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load course details');
    }
  }
}
