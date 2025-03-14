import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import '../../../../presentation/screens/ProfileScreen/data/models/user.dart'; // Yuqoridagi User modelni import qilish

class ProfileService {
  static const String baseUrl = 'http://84.247.139.211:8000/user'; // API manzili

  /// SharedPreferences orqali foydalanuvchi ma'lumotlarini olish
  Future<Map<String, String?>> _getUserDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    String? token = prefs.getString('token');
    return {'user_id': userId, 'token': token};
  }

  /// Foydalanuvchi profilini olish
  Future<User> getUserProfile() async {
    final userData = await _getUserDataFromSharedPreferences();
    final userId = userData['user_id'];
    final token = userData['token'];

    // User ID va tokenning mavjudligini tekshirish
    if (userId == null || userId.isEmpty) {
      throw Exception('User ID bo\'sh.');
    }
    if (token == null || token.isEmpty) {
      throw Exception('Token bo\'sh.');
    }

    // Konsolga foydalanuvchi ma'lumotlarini chiqarish
    print("===========================================");
    print('User ID: $userId');
    print('Authorization Token: Bearer $token');

    // So'rov URL'ini shakllantirish
    final url = '$baseUrl/$userId';
    print('Requesting URL: $url');

    try {
      // HTTP GET so'rovi
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Tokenni yuborish
        },
      );

      // Javobni tekshirish
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

  /// SharedPreferences orqali foydalanuvchi ma'lumotlarini saqlash
  Future<void> saveUserDataToSharedPreferences(
      {required String userId, required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('token', token);
    print('User data saqlandi: user_id=$userId, token=$token');
  }
}
