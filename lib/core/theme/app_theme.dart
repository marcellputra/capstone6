import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    // Primary Colors (match existing home/nav)
    primaryColor: const Color(0xFF40627B),
    scaffoldBackgroundColor: const Color(0xFFF7F9FB),

    // Typography
    textTheme: GoogleFonts.poppinsTextTheme(),

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF40627B),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    // Cards
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF40627B),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    // TextFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF40627B), width: 2),
      ),
    ),
  );

  // Gradient utilities
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [Color(0xFFBBDEFB), Color(0xFF90CAF9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get analysisGradient => const LinearGradient(
    colors: [Color(0xFFBBDEFB), Color(0xFFC9E7CA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
