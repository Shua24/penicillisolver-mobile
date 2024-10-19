import 'package:flutter/material.dart';
import 'package:penicillisolver/PengaturanAkun.dart';
import 'package:penicillisolver/polaKuman.dart';
import 'package:penicillisolver/verifikasi.dart';
import 'package:penicillisolver/verifikasiBerhasil.dart';
import 'LoginBerhasil.dart'; // Pastikan ini diimpor jika dibutuhkan
import 'lupa.dart'; // Pastikan ini diimpor
import 'theme.dart'; // Pastikan ini diimpor jika dibutuhkan
import 'register.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Terapkan tema
      title: 'PenicilliSolver',
      initialRoute: '/', // Setel rute awal
      routes: {
        '/': (context) => const Landing(), // Halaman awal
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const Register(),
        '/LoginBerhasil': (context) => const Selamat(),
        '/lupa': (context) => const Lupa(),
        '/verifikasi': (context) => const Verifikasi(),
        '/VerifikasiBerhasil': (context) => const VerifikasiBerhasil(),
        '/polaKuman': (context) =>
            const Polakuman(),  // Rute ke halaman Lupa Password
        '/PengaturanAkun': (context) => PengaturanAkun(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) =>
              const Landing(), // Halaman default jika rute tidak dikenali
        );
      },
    );
  }
}
