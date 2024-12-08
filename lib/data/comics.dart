import 'models/comics.dart';

final List<Comic> comics = List.generate(53, (index) {
  return Comic(
    title: 'Comic Title ${index + 1}',
    author: 'Author ${index + 1}',
    description:
        'This is the description of Comic Title ${index + 1}. It is an engaging and popular comic.',
    genre: [
      'Action',
      'Adventure',
      'Horror',
      'Sci-Fi'
    ][index % 4], // Cycle through genres
    releaseDate: DateTime(2020 + (index % 5), (index % 12) + 1,
        (index % 28) + 1), // Randomize release dates
    popularityScore:
        (index % 10) * 10.0 + 50.0, // Generate scores between 50 and 140
    posterUrl: 'assets/comics/image_${index + 1}.jpg',
    price: 5.99 + (index % 10), // Randomize prices
    isActive: index % 2 == 0, // Alternate active status
  );
});
