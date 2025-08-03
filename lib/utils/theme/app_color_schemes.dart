import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff0B3C7E);
  static const Color secondaryColor = Color(0xFF185994);
  static const Color tertiaryColor = Color(0xFFFBAA1A);
  static const Color hintColor = Color(0xFF999999);
  static const Color errorColor = Color(0xFFcc3300);
  static const Color successColor = Color(0xFF339900);
}

class AppColorSchemes {
  // --------------------------------------
  // Light Color scheme
  // --------------------------------------
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.white,
    error: AppColors.errorColor,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    outline: AppColors.hintColor,
    tertiary: AppColors.tertiaryColor,
    onTertiary: Colors.white,
  );

  // --------------------------------------
  // Dark Color scheme
  // --------------------------------------
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.white,
    error: AppColors.errorColor,
    onError: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
    outline: AppColors.hintColor,
    tertiary: AppColors.tertiaryColor,
    onTertiary: Colors.white,
  );
}
