import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  static const String baseUrl = 'http://3.123.128.20:8000/user';

  // Constructor
  ApiClient({Dio? dio}) : _dio = dio ?? Dio();

  // Initialize Dio with necessary configurations
  void init() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000 as Duration?;  // Set connection timeout
    _dio.options.receiveTimeout = 3000 as Duration?;  // Set receive timeout
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }

  // Generic GET method for API requests
  Future<Response> get(String url, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
