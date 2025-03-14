class Course {
  final int id;
  final String title;
  final String description;
  final int priceTutor;
  final int priceNoTutor;
  final String createdAt;
  final String updatedAt;
  final String? imageUrl;  // New field for image URL

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.priceTutor,
    required this.priceNoTutor,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,  // Allow image URL to be nullable
  });

  /// JSONdan bitta Course obyektini yaratish
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priceTutor: json['price_tutor'],
      priceNoTutor: json['price_no_tutor'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],  // Add image URL if available
    );
  }

  /// JSONdan List<Course> yaratish
  static List<Course> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }
}
