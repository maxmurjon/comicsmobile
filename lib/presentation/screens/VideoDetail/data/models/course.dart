import 'dart:convert';
import 'package:http/http.dart' as http;

class Course {
  final int id;
  final String title;
  final String description;
  final double priceTutor;
  final double priceNoTutor;
  final String createdAt;
  final String updatedAt;
  final String? imageUrl;
  final String? videoUrl;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.priceTutor,
    required this.priceNoTutor,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
    this.videoUrl,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priceTutor: json['price_tutor'].toDouble(),
      priceNoTutor: json['price_no_tutor'].toDouble(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
      videoUrl: json['video_url'],
    );
  }

  static List<Course> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }
}

class Section {
  final int id;
  final int courseId;
  final String title;

  Section({
    required this.id,
    required this.courseId,
    required this.title,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      courseId: json['course_id'],
      title: json['title'],
    );
  }
}

class Video {
  final int id;
  final int sectionId;
  final String title;
  final int duration;
  final String url;

  Video({
    required this.id,
    required this.sectionId,
    required this.title,
    required this.duration,
    required this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      sectionId: json['section_id'],
      title: json['title'],
      duration: json['duration'],
      url: json["url"],
    );
  }
}

Future<List<Section>> fetchSections(int courseId) async {
  final response = await http.get(Uri.parse('http://84.247.139.211:8000/coursesections/$courseId'));

  // Konsolda response ma'lumotlarini chiqarish
  print('Response for fetchSections:');
  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    // Asosiy obyektdan `sections` kalitini o'qib olish
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    List<dynamic> sectionsJson = decodedJson['sections']; // Faqat `sections` ni ajratib olish
    return sectionsJson.map((json) => Section.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load sections: ${response.body}');
  }
}


Future<List<Video>> fetchVideos(int sectionId) async {
  final response = await http.get(Uri.parse('http://84.247.139.211:8000/sectionvideos/$sectionId'));

  // Konsolda response ma'lumotlarini chiqarish
  print('Response for fetchVideos:');
  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    // Asosiy obyektdan `videos` kalitini o'qib olish
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    List<dynamic> videosJson = decodedJson['videos']; // Faqat `videos` ni ajratib olish
    return videosJson.map((json) => Video.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load videos: ${response.body}');
  }
}
