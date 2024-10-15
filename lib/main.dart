import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'theme.dart';
import 'register.dart';
import 'login.dart';
// import 'loading_page.dart'; // Pastikan ini diimpor jika ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Apply the theme
      title: 'PenicilliSolver',
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => const Landing(), // Halaman awal
        '/login': (context) => const LoginScreen(), // Rute ke Login
        '/register': (context) => const Register(),
        '/MainMenu': (context) => const Selamat() // Rute ke Register
      },
    );
  }
}
