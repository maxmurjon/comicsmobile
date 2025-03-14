import 'package:flutter/material.dart';
import '../screens/Auth/data/auth_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;

  Future<void> signIn(String phoneNumber, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final authService = AuthService();
      final response = await authService.signIn(phoneNumber: phoneNumber, password: password);

      if (response.containsKey('error')) {
        throw Exception(response['error']);
      }

      _token = response['token'];
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _token = null;
    notifyListeners();
  }
}
