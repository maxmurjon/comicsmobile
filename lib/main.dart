import 'package:comics/screens/Auth/welcome.dart';
import 'package:comics/screens/ProfileDetail/profile_detail.dart';
import 'package:flutter/material.dart';
import 'screens/profile_screen/profile_screen.dart';
import 'screens/category/category_screen.dart';
import 'screens/wishlist/wishlist.dart';
import 'screens/ComicDetailScreen/comic_detail_screen.dart'; // Mahsulot sahifasi

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      initialRoute: '/', // Ilova ishga tushganda boshlanadigan sahifa
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => WelcomeScreen());
          case '/profile':
            return MaterialPageRoute(
                builder: (context) => const ProfileScreen());
          case '/category':
            return MaterialPageRoute(
                builder: (context) => const CategoryScreen());
          case '/wishlist':
            return MaterialPageRoute(
                builder: (context) => const WishlistScreen());
          case '/product':
            // Dinamik argument: Mahsulot ID olish
            final productId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => ComicDetailScreen(productId: productId),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text('404 Not Found')),
              ),
            );
        }
      },
    );
  }
}
