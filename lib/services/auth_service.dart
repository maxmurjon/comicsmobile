import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://18.197.178.186:8000'; // Backend URL

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

    // Print the request data in terminal
    print('Request Body for SignUp:');
    print(jsonEncode(body));

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Print the response data in terminal
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully registered
        return jsonDecode(response.body);
      } else {
        // Handle error response
        return {'error': 'Failed to sign up'};
      }
    } catch (e) {
      // Catch network or other errors
      print('Error: $e');  // Print error in terminal
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
      // Request data for sign in
      print('Request URL for SignIn: $url');
      print('Request Body: ${jsonEncode(body)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Print the response data in terminal
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Invalid credentials'};
      }
    } catch (e) {
      print('Error: $e'); // Print error in terminal
      return {'error': e.toString()};
    }
  }
}