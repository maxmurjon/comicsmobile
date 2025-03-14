import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSource({required this.sharedPreferences});

  // Auth tokenni saqlash
  Future<void> saveAuthToken(String token) async {
    await sharedPreferences.setString('auth_token', token);
  }

  // Auth tokenni olish
  Future<String?> getAuthToken() async {
    return sharedPreferences.getString('auth_token');
  }

  // Auth tokenni o'chirish
  Future<void> removeAuthToken() async {
    await sharedPreferences.remove('auth_token');
  }
}
