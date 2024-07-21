import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_text_styles.dart';

abstract class AppStyles {
  static ThemeData get lightTheme {
    const mainColor = Colors.blueGrey;
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: mainColor, brightness: Brightness.light),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.blueGrey[200],
        backgroundColor: Colors.blueGrey[200],
      ),
      fontFamily: AppTextStyles.mainFontFamily,
      textTheme: AppTextStyles.commonTextTheme,
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.sp),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.2,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.sp),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.8,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide: BorderSide(
            color: Colors.redAccent[400]!,
            width: 1.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.sp),
          borderSide: BorderSide(
            color: Colors.redAccent[400]!,
            width: 1.2,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const mainColor = Colors.blueGrey;
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(seedColor: mainColor, brightness: Brightness.dark),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.blueGrey[800],
        backgroundColor: Colors.blueGrey[800],
      ),
      fontFamily: AppTextStyles.mainFontFamily,
      textTheme: AppTextStyles.commonTextTheme,
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.sp),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.2,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.sp),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.8,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.sp),
          borderSide: BorderSide(
            color: Colors.redAccent[400]!,
            width: 1.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.sp),
          borderSide: BorderSide(
            color: Colors.redAccent[400]!,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
