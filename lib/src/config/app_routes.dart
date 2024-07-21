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
        return _launchRoute(settings);
      case RouteNames.bookDetailsPage:
        var arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BookDetailsPage(details: arguments['details']),
          settings: settings,
        );
      case RouteNames.favoriteBooksPage:
        return _commonRoute(widget: const FavoriteBooksPage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen(), settings: settings);
    }
  }

  static Route<dynamic>? _launchRoute(RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            const HomePage(),
        settings: settings,
        transitionDuration: const Duration(milliseconds: 1200),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.fastEaseInToSlowEaseOut;
          const reverseCurve = Curves.fastOutSlowIn;

          final scaleTween = Tween<double>(begin: 1.5, end: 1.0);
          final scaleAnimation = CurvedAnimation(parent: animation, curve: curve, reverseCurve: reverseCurve);

          return ScaleTransition(
            scale: scaleTween.animate(scaleAnimation),
            child: child,
          );
        },
      );

  static Route<dynamic>? _commonRoute({required RouteSettings settings, required Widget widget}) => PageRouteBuilder(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    widget,
    settings: settings,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
