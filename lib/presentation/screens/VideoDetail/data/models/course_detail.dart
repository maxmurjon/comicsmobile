class CourseDetail {
  final int id;
  final String title;
  final String description;
  final int priceTutor;
  final int priceNoTutor;
  final String createdAt;
  final String updatedAt;

  CourseDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.priceTutor,
    required this.priceNoTutor,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priceTutor: json['price_tutor'],
      priceNoTutor: json['price_no_tutor'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
