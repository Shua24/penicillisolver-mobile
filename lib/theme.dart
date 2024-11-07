// theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(37, 160, 237, 1),
        titleTextStyle: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(37, 160, 237, 1),
          padding: const EdgeInsets.symmetric(
            horizontal: 150,
            vertical: 20,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color.fromRGBO(37, 160, 237, 1),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(37, 160, 237, 1),
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: Color.fromRGBO(37, 160, 237, 1),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 114, 114, 114),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 1, 35, 57),
        ),
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(
        fillColor: const Color.fromRGBO(37, 160, 237, 1),
        borderWidth: 2,
        selectedBorderColor: const Color.fromRGBO(37, 160, 237, 1),
        selectedColor: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
      ));
}
