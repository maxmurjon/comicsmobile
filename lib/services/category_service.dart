import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  final String baseUrl = "http://3.123.128.20:8000"; // Asosiy URL

  // Kategoriyalarni olish metodi
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categorys'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> categoriesJson = data['categories'];

        // Console'ga serverdan olingan ma'lumotlarni chiqarish
        print('Fetched Categories: $categoriesJson');

        // JSON-dan obyektga aylantirish
        return categoriesJson.map((json) => Category.fromJson(json, baseUrl)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}

// Category model
class Category {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  // JSON-dan obyektga aylantirish
  factory Category.fromJson(Map<String, dynamic> json, String baseUrl) {
    final String fullImageUrl = '$baseUrl/${json['image_url']}'; // Base URL qo'shish

    return Category(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: fullImageUrl, // To'liq URLni saqlash
    );
  }
}
