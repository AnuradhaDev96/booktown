import 'package:flutter/material.dart';

import '../ui/pages/book_details/book_details_page.dart';
import '../ui/pages/favorite_books/favorite_books_page.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/splash_screen.dart';

/// All route names
abstract class RouteNames {
  static const splashScreen = '/';
  static const homePage = '/home_page';

  static const bookDetailsPage = '/book_details_page';
  static const favoriteBooksPage = '/favorite_books_page';
}

/// Declares the route names and the pages with arguments
abstract class RouteConfig {
  /// Generate routes by route name and arguments
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage(), settings: settings);
      case RouteNames.bookDetailsPage:
        var arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BookDetailsPage(details: arguments['details']),
          settings: settings,
        );
      case RouteNames.favoriteBooksPage:
        return MaterialPageRoute(builder: (context) => const FavoriteBooksPage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen(), settings: settings);
    }
  }
}
