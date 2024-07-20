import 'package:flutter/material.dart';

/// Declares reusable keys
abstract class WidgetKeys {
  /// Main navigator key used in main flow
  static final mainNavKey = GlobalKey<NavigatorState>();

  /// Main messenger key configured at MaterialApp level
  static final mainScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Home page scaffold key
  static final GlobalKey<ScaffoldState> homePageKey = GlobalKey<ScaffoldState>();
}
