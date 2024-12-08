// models/comic.dart
class Comic {
  final String title;
  final String author;
  final String description;
  final String genre;
  final DateTime releaseDate;
  final double popularityScore;
  final String posterUrl;
  final double price;
  final bool isActive;

  Comic({
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.releaseDate,
    required this.popularityScore,
    required this.posterUrl,
    required this.price,
    required this.isActive,
  });
}
