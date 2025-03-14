import 'package:comics/presentation/screens/MyCource/Course/course.dart';
import 'package:flutter/material.dart';
import 'package:comics/presentation/screens/Auth/presentation/welcome.dart';
import 'package:comics/presentation/screens/ProfileScreen/presentation/components/profile_screen.dart';
import 'package:comics/presentation/screens/category/category_screen.dart';
import 'package:comics/presentation/screens/wishlist/wishlist.dart';
import 'package:comics/presentation/screens/ComicDetailScreen/comic_detail_screen.dart';

class AppRoutes {
  // Route nomlari
  static const String welcome = '/';
  static const String profile = '/profile';
  static const String category = '/category';
  static const String wishlist = '/wishlist';
  static const String product = '/product';
  // static const String comics

  // Route'larni boshqarish
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case category:
        return MaterialPageRoute(builder: (context) => const CategoryScreen());
      case wishlist:
        return MaterialPageRoute(builder: (context) => const WishlistScreen());
      case product:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ComicDetailScreen(productId: productId),
        );
      // case course:
      //   final courseId = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (context) => CourseDetailScreen(course: courseId),
      //   );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('404 Not Found')),
          ),
        );
    }
  }
}
