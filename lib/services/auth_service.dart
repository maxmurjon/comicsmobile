import 'dart:convert';
import 'package:http/http.dart' as http;

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
        // Save the token and userId
        _token = data['token'];
        _userId = data['user_id'];
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
        // Save the token and userId
        _token = data['token'];
        _userId = data['user_id'];
        return data;
      } else {
        return {'error': 'Invalid credentials'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
