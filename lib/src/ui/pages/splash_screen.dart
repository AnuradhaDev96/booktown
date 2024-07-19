import 'package:flutter/material.dart';

import '../../config/app_routes.dart';
import '../../config/widget_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _navigateHome());
    super.initState();
  }

  // Display home page
  void _navigateHome() {
    WidgetKeys.mainNavKey.currentState!.pushNamedAndRemoveUntil(RouteNames.homePage, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("BookTown"),
      ),
    );
  }
}
