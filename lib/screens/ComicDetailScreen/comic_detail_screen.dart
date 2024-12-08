import 'package:flutter/material.dart';
import 'components/comic_poster.dart';
import 'components/comic_info.dart';
import 'components/comic_list.dart';

class ComicDetailScreen extends StatefulWidget {
  final String productId; // Dinamik parametr

  const ComicDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _ComicDetailScreenState createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {
  List<String> wishlist = [];

  // Foydalanuvchidan ma'lumotlar olish uchun, bu modelni ko'rib chiqing
  String title = "Comic Title";
  String author = "Author Name";
  String description = "Comic Description";
  String genre = "Genre";
  DateTime releaseDate = DateTime.now();
  double popularityScore = 4.5;
  String posterUrl = "https://example.com/poster.jpg";
  double price = 10.0;
  List<String> similarComics = ["Comic 1", "Comic 2", "Comic 3"];

  @override
  void initState() {
    super.initState();
    // `productId` orqali haqiqiy ma'lumotlarni olish jarayoni
    _fetchComicDetails(widget.productId);
  }

  // Bu funksiya, haqiqiy ma'lumotlarni serverdan olishga mos bo'lishi mumkin
  void _fetchComicDetails(String productId) {
    // Misol uchun, productId yordamida ma'lumotlarni olish
    // Bu yerda buni simulyatsiya qilaman
    setState(() {
      title = "Amazing Comic"; // Ma'lumotlar serverdan olinadi
      author = "Jane Doe";
      description = "This is a detailed description of the comic.";
      genre = "Action";
      releaseDate = DateTime(2020, 5, 15);
      popularityScore = 4.8;
      posterUrl = "https://example.com/poster.jpg";
      price = 15.0;
      similarComics = ["Comic A", "Comic B", "Comic C"];
    });
  }

  // Wishlistga qo'shish funksiyasi
  void _addToWishlist(String comicTitle) {
    setState(() {
      if (!wishlist.contains(comicTitle)) {
        wishlist.add(comicTitle);
      }
    });

    // Istalgan joyda xabar berish mumkin
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$comicTitle added to wishlist!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ComicPoster(posterUrl: posterUrl),
                  ComicInfo(
                    title: title,
                    author: author,
                    genre: genre,
                    releaseDate: releaseDate,
                    popularityScore: popularityScore,
                    description: description,
                    price: price,
                  ),
                  ComicList(comics: similarComics),
                ],
              ),
            ),
          ),
          // Pastki panel
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price: \$${price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addToWishlist(title);
                  },
                  child: const Text("Add to Wishlist"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
