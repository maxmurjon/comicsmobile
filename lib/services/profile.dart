import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/user.dart'; // Yuqoridagi modelni import qilish

class ProfileService {
  static const String baseUrl = 'http://3.123.128.20:8000/user'; // API manzili
  static String? userId = "51097c15-273a-4ca4-a844-3a49d3789733"; // User IDni saqlash uchun
  static String? token; // Tokenni saqlash uchun

  Future<User> getUserProfile() async {
    if (userId == null ) {
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
