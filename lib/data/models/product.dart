class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls; // Ro'yxat sifatida o'zgartirildi

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
  });

  /// JSON-dan Product yaratish
  factory Product.fromJson(Map<String, dynamic> json, List<String> imageUrls) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '', // Default qiymat
      price: (json['price'] as num).toDouble(),
      imageUrls: imageUrls, // JSON bilan kelgan rasm URLlari ro'yxati
    );
  }
}
