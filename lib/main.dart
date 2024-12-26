import 'package:flutter/material.dart';
import 'package:penicillisolver/pengaturan_akun.dart';
import 'package:penicillisolver/verifikasi.dart';
import 'package:penicillisolver/lupa.dart';
import 'package:penicillisolver/theme.dart';
import 'package:penicillisolver/register.dart';
import 'package:penicillisolver/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import file konfigurasi Firebase

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( // Inisialisasi Firebase dengan konfigurasi
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      title: 'PenicilliSolver',
      initialRoute: '/',
      routes: {
        '/': (context) => const Landing(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const Register(),
        '/lupa': (context) => const Lupa(),
        '/verifikasi': (context) => const Verifikasi(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Landing(),
        );
      },
    );
  }
}
