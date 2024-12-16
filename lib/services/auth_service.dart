import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  // Helper method to save token and userId locally using SharedPreferences
  Future<void> _saveTokenAndUserId(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data['token']);
    await prefs.setString('user_id', data['user_id']);
    _token = data['token'];
    _userId = data['user_id'];
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
        await _saveTokenAndUserId(data); // Save token and userId locally
        return data;
      } else {
        final errorData = jsonDecode(response.body);
        return {'error': errorData['message'] ?? 'Failed to sign up'};
      }
    } catch (e) {
      return {'error': 'Error: ${e.toString()}'};
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
        await _saveTokenAndUserId(data); // Save token and userId locally
        return data;
      } else {
        final errorData = jsonDecode(response.body);
        return {'error': errorData['message'] ?? 'Invalid credentials'};
      }
    } catch (e) {
      return {'error': 'Error: ${e.toString()}'};
    }
  }

  // Logout method
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id');
    _token = null;
    _userId = null;
  }
}
