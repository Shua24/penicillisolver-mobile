// theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
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
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(37, 160, 237, 1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(37, 160, 237, 1),
        ),
      ),
      floatingLabelStyle: TextStyle(
        color: Color.fromRGBO(37, 160, 237, 1),
      ),
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 114, 114, 114),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 1, 35, 57),
      ),
    ),
  );
}
