import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  /// Dark theme
  static const darkBg = Color(0xFF0A0E1A);
  static const darkSurface = Color(0xFF111827);
  static const darkCard = Color(0xFF1A2235);
  static const darkBorder = Color(0xFF1E2D45);

  /// Light theme
  static const lightBg = Color(0xFFF0F4FF);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFEBF0FF);
  static const lightBorder = Color(0xFFCDD7F0);

  /// Accent - Flutter-inspired teal-blue
  static const accent = Color(0xFF00D4FF);
  static const accentGlow = Color(0xFF0066FF);
  static const accentSecondary = Color(0xFF7C3AED);
  static const accentGreen = Color(0xFF00E5B0);

  /// Text
  static const darkText = Color(0xFFE8F0FF);
  static const darkTextMuted = Color(0xFF7A90B8);
  static const lightText = Color(0xFF0A1A40);
  static const lightTextMuted = Color(0xFF4A5C80);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.accentSecondary,
      surface: AppColors.darkSurface,
    ),
    textTheme: GoogleFonts.spaceGroteskTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    ),
    useMaterial3: true,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.accentGlow,
      secondary: AppColors.accentSecondary,
      surface: AppColors.lightSurface,
    ),
    textTheme: GoogleFonts.spaceGroteskTextTheme(
      ThemeData.light().textTheme,
    ).apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText,
    ),
    useMaterial3: true,
  );
}

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}