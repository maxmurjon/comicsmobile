import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  factory AuthService() => _singleton;

  AuthService._internal();

  final String baseUrl = 'http://3.123.128.20:8000'; // Backend URL

  String? _token;
  String? _userId;

  // Getter methods to access token and userId
  String? get token => _token;
  String? get userId => _userId;

  // Save token and userId to shared preferences
  Future<void> _saveAuthData(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userId', userId);
  }

  // Load token and userId from shared preferences
  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _userId = prefs.getString('userId');
  }

  // Sign up method
  Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    final String? imageUrl,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    // Request body
    final body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'image_url': imageUrl,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        // Save the token and userId to shared preferences
        await _saveAuthData(data['token'], data['user_id']);
        return data;
      } else {
        return {'error': 'Failed to sign up'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // Sign in method
  Future<Map<String, dynamic>> signIn({
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    final body = {
      'phone_number': phoneNumber,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        // Save the token and userId to shared preferences
        await _saveAuthData(data['token'], data['user_id']);
        return data;
      } else {
        return {'error': 'Invalid credentials'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // Load auth data when the app starts
  Future<void> loadAuthData() async {
    await _loadAuthData();
  }

  // Clear auth data
  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
  }
}
