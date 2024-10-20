import 'package:flutter/material.dart';
import 'package:penicillisolver/PengaturanAkun.dart';
import 'package:penicillisolver/verifikasi.dart';
import 'package:penicillisolver/verifikasiBerhasil.dart';
import 'package:penicillisolver/LoginBerhasil.dart';
import 'package:penicillisolver/lupa.dart';
import 'package:penicillisolver/theme.dart';
import 'package:penicillisolver/register.dart';
import 'package:penicillisolver/login.dart';

void main() {
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
        '/LoginBerhasil': (context) => const Selamat(),
        '/lupa': (context) => const Lupa(),
        '/verifikasi': (context) => const Verifikasi(),
        '/VerifikasiBerhasil': (context) => const VerifikasiBerhasil(),
        '/PengaturanAkun': (context) => PengaturanAkun(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Landing(),
        );
      },
    );
  }
}
