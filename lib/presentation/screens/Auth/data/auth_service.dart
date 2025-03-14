import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  factory AuthService() => _singleton;

  AuthService._internal();

  final String baseUrl = 'http://84.247.139.211:8000'; // Backend URL

  String? _token;
  String? _userId;

  String? get token => _token;
  String? get userId => _userId;

// Save token and user_id to shared preferences
  Future<void> _saveToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (_token != null) {
      prefs.setString('token', _token!);
    }
    if (_userId != null) {
      prefs.setString('user_id', _userId!);
    }
    print('Saved token: $_token, user_id: $_userId');
  }

// Load token and user_id from shared preferences
  Future<void> _loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _userId = prefs.getString('user_id');
    print('Loaded token: $_token, user_id: $_userId');
  }

// Initialize AuthService
  Future<void> initializeAuthService() async {
    await _loadFromSharedPreferences();
  }

// Sign up method
  Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? imageUrl,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');
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
        print('SignUp Response: $data');

        await logOut(); // Eski ma'lumotlarni tozalash
        _token = data['token'];
        _userId = data['user_id'];
        await _saveToSharedPreferences();

        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception('SignUp Error: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Error during sign up: $e');
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
        print('SignIn Response: $data');

        await logOut(); // Eski ma'lumotlarni tozalash
        _token = data['token'];
        _userId = data['user_data']['id'];
        await _saveToSharedPreferences();

        return data;
      } else {
        final error = jsonDecode(response.body);
        throw Exception('SignIn Error: ${error['message']}');
      }
    } catch (e) {
      throw Exception('Error during sign in: $e');
    }
  }

// Check if the user is logged in
  Future<bool> isLoggedIn() async {
    await _loadFromSharedPreferences();
    return _token != null && _userId != null;
  }

// Log out and clear shared preferences
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hamma ma'lumotlarni tozalash
    _token = null;
    _userId = null;
    print('Logged out and preferences cleared');
  }
}
