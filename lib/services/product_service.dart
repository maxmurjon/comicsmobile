import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/product.dart';

class ProductService {
  static const String productUrl = 'http://18.197.178.186:8000/products';
  static const String imageUrl = 'http://18.197.178.186:8000/productimages';

  Future<List<Product>> fetchProducts() async {
    final productResponse = await http.get(Uri.parse(productUrl));
    final imageResponse = await http.get(Uri.parse(imageUrl));

    if (productResponse.statusCode == 200 && imageResponse.statusCode == 200) {
      final productData = jsonDecode(productResponse.body);
      final imageData = jsonDecode(imageResponse.body);

      List<Product> products = [];
      for (var productJson in productData['products']) {
        String? imageUrl;
        for (var imageJson in imageData['product_image']) {
          if (imageJson['product_id'] == productJson['id'] && imageJson['is_primary']) {
            imageUrl = 'http://18.197.178.186:8000/${imageJson['image_url']}';
            break;
          }
        }
        products.add(Product.fromJson(productJson, imageUrl));
      }
      return products;
    } else {
      throw Exception('Failed to fetch products or images');
    }
  }
}
