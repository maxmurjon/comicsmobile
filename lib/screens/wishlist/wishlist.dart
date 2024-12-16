import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // Wishlistda saqlanadigan mahsulotlar ro'yxati
  final List<Map<String, String>> _wishlistItems = [
    {'title': 'Spider-Man: No Way Home', 'image': 'assets/comics/image_1.jpg'},
    {'title': 'Avengers: Endgame', 'image': 'assets/comics/image_2.jpg'},
    {'title': 'Batman: The Dark Knight', 'image': 'assets/comics/image_3.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _wishlistItems.isEmpty
          ? const Center(
              child: Text(
                'Sizning Wishlist bo\'sh!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _wishlistItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(
                      _wishlistItems[index]['image']!,
                      height: 50,
                      width: 50,
                    ),
                    title: Text(
                      _wishlistItems[index]['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Wishlistdan olib tashlash
                        setState(() {
                          _wishlistItems.removeAt(index);
                        });
                      },
                    ),
                    onTap: () {
                      // Mahsulotga bo'lgan qo'shimcha ma'lumotni ko'rsatish
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(_wishlistItems[index]['title']!),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(_wishlistItems[index]['image']!),
                              const SizedBox(height: 10),
                              Text('Bu mahsulot haqida qo\'shimcha ma\'lumot.'),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Yopish'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
