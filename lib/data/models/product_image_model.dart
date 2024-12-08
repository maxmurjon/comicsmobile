class ProductImage {
  final int id;
  final int productId;
  final String imageUrl;
  final bool isPrimary;

  ProductImage({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.isPrimary,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['product_id'],
      imageUrl: json['image_url'],
      isPrimary: json['is_primary'],
    );
  }
}
