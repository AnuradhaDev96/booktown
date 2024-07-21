import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

abstract class AppTextStyles {
  /// Use for primary font family
  static const String mainFontFamily = 'Lexend';

  static TextTheme commonTextTheme = TextTheme(
    titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, height: 0),
    titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 0),
  );
}
