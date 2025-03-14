import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImageService {
  static const String baseUrl = 'http://84.247.139.211:8000'; // API manzili

  // Rasmni yuklash
  Future<bool> uploadProfileImage(File image) async {
    try {
      final userData = await _getUserDataFromSharedPreferences();
      final userId = userData['user_id'];
      final token = userData['token'];

      // Check if userId or token is empty
      if (userId == null || userId.isEmpty || token == null || token.isEmpty) {
        throw Exception('Foydalanuvchi ma\'lumotlari mavjud emas.');
      }

      final url = Uri.parse('$baseUrl/uploaduserimage'); // User ID endpointga qo'shiladi

      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token' // Tokenni Authorization headerda yuborish
        ..fields['user_id'] = userId // User ID qo'shish
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', _getFileExtension(image.path)), // Rasm turi dinamikani qo'llash
        ));

      final response = await request.send();

      // Checking the response status and returning the appropriate result
      if (response.statusCode == 200) {
        print("Success");
        return true; // Rasm muvaffaqiyatli yuklandi
      } else {
        final responseBody = await response.stream.bytesToString();
        print("Failed: ${response.statusCode}, $responseBody");
        return false; // Rasmni yuklashda xatolik
      }
    } catch (e) {
      print('Error uploading image: $e');
      return false; // Xatolik yuz berdi
    }
  }

  // SharedPreferences'dan foydalanuvchi ma'lumotlarini olish
  Future<Map<String, String>> _getUserDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    final token = prefs.getString('token');

    if (userId == null || token == null) {
      throw Exception('Foydalanuvchi ma\'lumotlari topilmadi.');
    }

    return {
      'user_id': userId,
      'token': token,
    };
  }

  // Foydalanuvchi rasmning kengaytmasini olish
  String _getFileExtension(String filePath) {
    final extension = filePath.toLowerCase(); // File extensioni olish
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'jpeg';
      case '.png':
        return 'png';
      default:
        return 'jpeg'; // Standart kengaytma
    }
  }
}
