class Section {
  final int id;
  final int courseId;
  final String title;
  final int order;
  final String createdAt;

  Section({
    required this.id,
    required this.courseId,
    required this.title,
    required this.order,
    required this.createdAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      courseId: json['course_id'],
      title: json['title'],
      order: json['order'],
      createdAt: json['created_at'],
    );
  }
}
