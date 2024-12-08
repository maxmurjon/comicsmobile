import 'package:flutter/material.dart';
import './screens/home/home_screen.dart';
import './screens/category/category_screen.dart';
// import './screens/wishlist_screen.dart';
import './screens/profile_screen/profile_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String category = '/category';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case category:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      // case wishlist:
      //   return MaterialPageRoute(builder: (_) => const WishlistScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
