import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences import qilish
import '../data/models/user.dart'; // Yuqoridagi modelni import qilish

class ProfileService {
  static const String baseUrl = 'http://3.123.128.20:8000/user'; // API manzili
  static String? userId; // User IDni saqlash uchun
  static String? token; // Tokenni saqlash uchun

  // SharedPreferences yordamida token va userId-ni o'qish
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');  // SharedPreferences'dan userId olish
    token = prefs.getString('token');      // SharedPreferences'dan token olish
  }

  // User profile ma'lumotlarini olish
  Future<User> getUserProfile() async {
    // Foydalanuvchi ID va token mavjudligini tekshirish
    if (userId == null || token == null) {
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
