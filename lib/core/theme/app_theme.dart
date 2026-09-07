import 'package:flutter/material.dart';

abstract final class AppColors {
  /// Private constructor for static utility class.
  // ignore: unnecessary_type_name_in_constructor
  const AppColors._();

  static const Color cyberBlack = Color(0xFF050A1A);
  static const Color cyberDark = Color(0xFF080F24);
  static const Color cyberCard = Color(0xFF0E1935);
  static const Color cyberCardAlt = Color(0xFF0A1226);
  static const Color cyberCardDeep = Color(0xFF111E42);
  static const Color cyberBorder = Color(0xFF003B8F);
  static const Color cyanBright = Color(0xFF00E5FF);
  static const Color primaryBlue = Color(0xFF00BFFF);
  static const Color deepBlue = Color(0xFF0066FF);
  static const Color darkBlue = Color(0xFF003B8F);
  static const Color cyberRed = Color(0xFFEF4444);
  static const Color cyberAmber = Color(0xFFFBBF24);
  static const Color cyberEmerald = Color(0xFF34D399);
  static const Color cyberDim = Color(0xFF475569);
  static const Color cyberMuted = Color(0xFF94A3B8);
}

abstract final class AppTheme {
  /// Private constructor for static utility class.
  // ignore: unnecessary_type_name_in_constructor
  const AppTheme._();

  static ThemeData darkCyberTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.cyberBlack,
    canvasColor: AppColors.cyberBlack,
    cardColor: AppColors.cyberCard,
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.cyberCard),
    primaryColor: AppColors.cyanBright,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.cyanBright,
      secondary: AppColors.primaryBlue,
      surface: AppColors.cyberCard,
    ),
    fontFamily: 'monospace',
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cyberDark,
      selectedItemColor: AppColors.cyanBright,
      unselectedItemColor: AppColors.cyberMuted,
    ),
  );
}
