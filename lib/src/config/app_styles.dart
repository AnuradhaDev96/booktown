import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_text_styles.dart';

abstract class AppStyles {
  static commonInputDecoration({
    String? labelText,
    Widget? label,
    String? hintText,
    Color? hintColor,
    Widget? suffixIcon,
    Widget? prefixIcon,
    EdgeInsetsGeometry? contentPadding,
  }) =>
      InputDecoration(
        hintText: hintText,
        labelText: labelText,
        label: label,
        counter: const SizedBox.shrink(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(fontWeight: FontWeight.w400, color: hintColor),
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.8,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      );

  static ThemeData get lightTheme {
    const mainColor = Colors.blueGrey;
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: mainColor, brightness: Brightness.light),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: const AppBarTheme(
        surfaceTintColor: mainColor,
        backgroundColor: mainColor,
      ),
      fontFamily: AppTextStyles.mainFontFamily,
      textTheme: AppTextStyles.commonTextTheme,
      useMaterial3: true,
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
    );
  }
}
