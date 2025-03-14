import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // Save user data (userId and token) to SharedPreferences
  Future<void> saveUserData({
    required String userId,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setString('token', token);
    print('User data saved: user_id=$userId, token=$token');
  }

  // Retrieve user data (userId and token) from SharedPreferences
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'user_id': prefs.getString('user_id'),
      'token': prefs.getString('token'),
    };
  }

  // Clear user data from SharedPreferences (for logout functionality)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('token');
    print('User data cleared');
  }
}
