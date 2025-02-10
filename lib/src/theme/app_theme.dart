import 'package:flutter/material.dart';

class AppTheme {
  // Couleurs principales
  static const Color terracotta = Color(0xFFE0897C); // Terracotta
  static const Color blancCasse = Color(0xFFFBF9F2); // Blanc cassé
  static const Color textDark = Color(0xFF2C2C2C); // Texte sombre
  static const Color textLight = Color(0xFF6B6B6B); // Texte clair

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: terracotta,
          onPrimary: blancCasse,
          background: blancCasse,
          surface: blancCasse,
          onSurface: textDark,
        ),

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: terracotta,
          foregroundColor: blancCasse,
          elevation: 0,
          centerTitle: true,
        ),

        // Cards
        cardTheme: CardTheme(
          color: blancCasse,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Floating Action Button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: terracotta,
          foregroundColor: blancCasse,
        ),

        // Text
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'AcuminProWide',
            color: textDark,
            fontSize: 24,
            fontWeight: FontWeight.w300, // Thin
          ),
          titleMedium: TextStyle(
            fontFamily: 'AcuminProWide',
            color: textDark,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'AcuminProWide',
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'AcuminProWide',
            color: textLight,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),

        // Input Decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: blancCasse,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: terracotta),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: terracotta, width: 2),
          ),
        ),
      );
}
