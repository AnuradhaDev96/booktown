import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
    // Future.delayed(
    //   const Duration(milliseconds: 1500),
    //   () => WidgetKeys.mainNavKey.currentState!.pushNamedAndRemoveUntil(
    //     RouteNames.homePage,
    //     (Route<dynamic> route) => false,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF0180C5),
              Color(0xFF20B9CD),
            ]
          )
        ),
        child: Center(
          child: Text(
            "Booktown",
            style: TextStyle(
              letterSpacing: -2,
              color: Colors.white,
              fontSize: 29.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
