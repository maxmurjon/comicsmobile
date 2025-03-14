import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../VideoDetail/data/models/course.dart'; // `Course` modelini import qilish

class GetCourse {
  final String baseUrl = "http://84.247.139.211:8000";

  /// Backenddan kurslar ro'yxatini olish
  Future<List<Course>?> fetchCourses() async {
    final Uri endpoint = Uri.parse(baseUrl).replace(path: '/courses');

    try {
      // APIga GET so'rov yuborish
      final response = await http.get(endpoint);

      // APIdan kelgan barcha javobni konsolda aks ettirish
      print("Response body: ${response.body}");

      // HTTP so'rov muvaffaqiyatli bo'lganini tekshirish
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Konsolda to'liq javob strukturasini aks ettirish
        print("Decoded Response: $responseData");

        if (responseData is Map<String, dynamic> && responseData.containsKey('courses')) {
          List<dynamic> coursesJson = responseData['courses'];
          return Course.fromJsonList(coursesJson); // Kurslarni modelga aylantirish
        } else {
          print("Unexpected response structure: $responseData");
          return null;
        }
      } else {
        print("Failed to fetch courses. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e, stackTrace) {
      // Xatoliklarni konsolda chop qilish
      print("Error fetching courses: $e");
      print("StackTrace: $stackTrace");
      return null;
    }
  }
}
