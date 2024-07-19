import 'package:flutter/material.dart';

import '../ui/pages/home/home_page.dart';
import '../ui/pages/splash_screen.dart';

/// All route names
abstract class RouteNames {
  static const splashScreen = '/';
  static const homePage = '/home_page';
}

/// Declares the route names and the pages with arguments
abstract class RouteConfig {
  /// Generate routes by route name and arguments
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen(), settings: settings);
    }
  }
}
