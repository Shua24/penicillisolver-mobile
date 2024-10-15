// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:penicillisolver/register.dart';
import 'package:penicillisolver/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool _obscureText1 = true; // Untuk Kata Sandi
  final bool _obscureText2 = true; // Untuk Konfirmasi Kata Sandi
  List<bool> isSelected = [true, false, false, false]; // Untuk pilihan tim

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Ini akan menangani tombol back fisik Android
        // Kembali ke halaman sebelumnya
        return true; // Mengizinkan back action default
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset(
                      'assets/logo1.png',
                    ), // Ubah ke logo yang sesuai
                  ),
                ),
                const SizedBox(height: 25),

                // Email Input Field
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email anda',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 170, 170, 170)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            37, 160, 237, 1), // Warna border saat tidak fokus
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            37, 160, 237, 1), // Warna border saat fokus
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Password Input Field
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kata Sandi',
                    style: TextStyle(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  obscureText: _obscureText1,
                  decoration: InputDecoration(
                    hintText: 'Kata Sandi Anda',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 170, 170, 170)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            37, 160, 237, 1), // Warna border saat tidak fokus
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(
                            37, 160, 237, 1), // Warna border saat fokus
                        width: 2,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText1 = !_obscureText1; // Toggle visibility
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                const SizedBox(height: 20),

                // Tombol Masuk
                SizedBox(
                  width: 400,
                  height: 50, // Mengatur lebar tombol
                  child: ElevatedButton(
                    onPressed: () {
                      // Aksi ketika tombol ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Mengatur warna latar belakang tombol
                      foregroundColor:
                          Colors.white, // Mengatur warna teks tombol
                    ),
                    child: const Text('Masuk'),
                  ),
                ),

                const SizedBox(height: 20),

                // Sudah punya akun / Login dengan
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum Punya Akun ?'),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Register()), // ganti LoginPage dengan nama class di login.dart
                          );
                        });
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: Color.fromRGBO(37, 160, 237, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Atau lanjutkan dengan:'),
                const SizedBox(height: 10),

                // Tombol Sosial Media (Google, Facebook, Twitter)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tombol Google
                    IconButton(
                      icon: Image.asset(
                        'assets/google.png',
                        width: 30,
                        height: 30,
                      ),
                      iconSize: 1,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 1),
                    // Tombol Facebook
                    IconButton(
                      icon: Image.asset(
                        'assets/fb.png',
                        width: 30,
                        height: 30,
                      ),
                      iconSize: 1,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 1),
                    // Tombol Twitter
                    IconButton(
                      icon: Image.asset(
                        'assets/x.png',
                        width: 30,
                        height: 30,
                      ),
                      iconSize: 1,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
