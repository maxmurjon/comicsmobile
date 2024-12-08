import '../data/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String productUrl = 'http://18.197.178.186:8000/products';
  static const String imageUrl = 'http://18.197.178.186:8000/productimages';

  Future<List<Product>> fetchProducts() async {
    try {
      final productResponse = await http.get(Uri.parse(productUrl));
      final imageResponse = await http.get(Uri.parse(imageUrl));

      // Javob muvaffaqiyatli bo'lishini tekshirish
      if (productResponse.statusCode == 200 && imageResponse.statusCode == 200) {
        final productData = jsonDecode(productResponse.body);
        final imageData = jsonDecode(imageResponse.body);

        // Terminalsda JSON javobini chiqarish
        print('Product Response: ${jsonEncode(productData)}');  // Mahsulotlar javobini chiqarish
        print('Image Response: ${jsonEncode(imageData)}');  // Rasm javobini chiqarish

        // Mahsulot ID'larini rasm ro'yxatiga moslash
        final Map<int, List<String>> productImages = {};
        for (var imageJson in imageData['product_image']) {
          final productId = imageJson['product_id'];
          final imageLink = 'http://18.197.178.186:8000/${imageJson['image_url']}';
          if (!productImages.containsKey(productId)) {
            productImages[productId] = [];
          }
          productImages[productId]!.add(imageLink);
        }

        // Mahsulotlarni yaratish va rasmlarni biriktirish
        List<Product> products = [];
        for (var productJson in productData['products']) {
          final productId = productJson['id'];
          final images = productImages[productId] ?? []; // Rasmlar mavjud bo'lmasa bo'sh ro'yxat
          products.add(Product.fromJson(productJson, images));
        }

        return products;
      } else {
        throw Exception('Mahsulotlar yoki rasmlarni olishda xatolik yuz berdi. Status kodi: ${productResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Ma\'lumotlarni olishda xatolik: $e');
    }
  }
}
