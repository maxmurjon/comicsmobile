import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  // Backend API URL
  final String apiUrl = "http://3.123.128.20:8000/profile";

  // Foydalanuvchi profilini olish
  Future<Map<String, dynamic>?> getProfile(String token, String userId) async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Tokenni yuborish
          'user_id': userId, // UserIDni yuborish
        },
      );

      if (response.statusCode == 200) {
        // Agar so'rov muvaffaqiyatli bo'lsa, JSONni qaytarish
        return jsonDecode(response.body);
      } else {
        // Xatolik holati
        print('Failed to load profile: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
