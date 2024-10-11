// theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.cyan,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(37, 160, 237, 1),
      titleTextStyle: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(37, 160, 237, 1),
      ),
    ),
  );
  // Text field langsung di halaman
}
