// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import './models/course.dart';
//
// class ApiService {
//   final String baseUrl;
//
//   ApiService(this.baseUrl);
//
//   // Kursni olish
//   Future<Course> getCourse(String courseId) async {
//     final response = await http.get(Uri.parse('$baseUrl/courses/$courseId'));
//
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       return Course.fromJson(json);
//     } else {
//       throw Exception('Failed to load course');
//     }
//   }
//
//   // Bo‘limlarni olish
//   Future<List<Map<String, dynamic>>> getSections(String courseId) async {
//     final response =
//     await http.get(Uri.parse('$baseUrl/courses/$courseId/sections'));
//
//     if (response.statusCode == 200) {
//       final List sections = jsonDecode(response.body);
//       return List<Map<String, dynamic>>.from(sections);
//     } else {
//       throw Exception('Failed to load sections');
//     }
//   }
// }
