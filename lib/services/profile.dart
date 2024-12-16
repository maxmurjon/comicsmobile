import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // shared_preferences import qilish
import '../data/models/user.dart'; // User modelini import qilish

class ProfileService {
  static const String baseUrl = 'http://3.123.128.20:8000/user'; // API manzili

  // Token va userId ni shared_preferences'dan olish
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Foydalanuvchi profilini olish
  Future<User> getUserProfile() async {
    final token = await _getToken();
    final userId = await _getUserId();

    if (token == null || userId == null) {
      throw Exception('User ID va token to\'ldirilmagan.');
    }

    final url = '$baseUrl/$userId';
    print('Requesting URL: $url');
    print('Authorization Token: Bearer $token');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Tokenni yuborish
        },
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['data']);
      } else {
        throw Exception(
          'Foydalanuvchi ma\'lumotlarini olishda xatolik yuz berdi. Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }
}
