import 'package:assets_app/core/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: ConstColors.primary,
        indicatorColor: ConstColors.primary,
        textTheme: const TextTheme(
            // titleLarge: TextStyle(color: ConstColors.primary),
            // titleSmall: TextStyle(color: ConstColors.primary),
            // titleMedium: TextStyle(color: ConstColors.primary),
            // headlineLarge: TextStyle(color: ConstColors.primary),
            // headlineMedium: TextStyle(color: ConstColors.primary),
            // headlineSmall: TextStyle(color: ConstColors.primary),
            )
        // scaffoldBackgroundColor: ConstColors.white,
        );
  }
}
