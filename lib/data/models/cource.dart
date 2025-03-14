// models.dart
class VideoCourse {
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final List<VideoModule> modules;

  VideoCourse({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.modules,
  });

  // Bu funksiya JSON formatidan object yaratish uchun kerak bo'ladi
  factory VideoCourse.fromJson(Map<String, dynamic> json) {
    return VideoCourse(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrls: List<String>.from(json['imageUrls']),
      modules: (json['modules'] as List)
          .map((module) => VideoModule.fromJson(module))
          .toList(),
    );
  }
}

class VideoModule {
  final String title;
  final String videoUrl;
  final List<Video> videos;

  VideoModule({
    required this.title,
    required this.videoUrl,
    required this.videos,
  });

  factory VideoModule.fromJson(Map<String, dynamic> json) {
    return VideoModule(
      title: json['title'],
      videoUrl: json['videoUrl'],
      videos: (json['videos'] as List)
          .map((video) => Video.fromJson(video))
          .toList(),
    );
  }
}

class Video {
  final String videoTitle;
  final String videoUrl;

  Video({
    required this.videoTitle,
    required this.videoUrl,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoTitle: json['videoTitle'],
      videoUrl: json['videoUrl'],
    );
  }
}
