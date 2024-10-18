// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';

void main() {
  runApp(const Selamat());
}

class Selamat extends StatelessWidget {
  const Selamat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginBerhasil(),
    );
  }
}

class LoginBerhasil extends StatefulWidget {
  const LoginBerhasil({super.key});

  @override
  _LoginBerhasilState createState() => _LoginBerhasilState();
}

class _LoginBerhasilState extends State<LoginBerhasil> {
  @override
  void initState() {
    super.initState();
    // Menunggu 5 detik sebelum berpindah halaman
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration:
              const Duration(milliseconds: 600), // Durasi transisi
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainMenu(), // Pastikan class Register sudah ada
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Mulai dari kanan
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/josh.png', width: 300),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
