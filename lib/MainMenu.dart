// ignore_for_file: file_names, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:penicillisolver/login.dart';
import 'package:penicillisolver/polaKuman.dart';
import 'package:penicillisolver/setting.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 155, 226),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Text(
                        'Menu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Image.asset(
                      'assets/user1.png', // Ganti dengan path gambar yang kamu inginkan
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            const Text(
              'Berikut Adalah Menu',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 100),

            // Menu Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PressableButton(
                        icon: Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                          child: Image.asset(
                            'assets/sakit.png',
                            width: 100,
                            height: 70,
                          ),
                        ),
                        title:
                            'Berdasarkan Penyakit', // Menggunakan string biasa
                        isCenter: true,
                        backgroundColor: const Color.fromARGB(255, 0, 189, 9),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Polakuman(),
                            ),
                          );
                        },
                      ),
                      PressableButton(
                        icon: Container(
                          margin: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Image.asset(
                            'assets/bakteri.png',
                            width: 120,
                            height: 70,
                          ),
                        ),
                        title: '   Cari Pola Kuman', // Menggunakan string biasa
                        isCenter: true,
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Polakuman(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  PressableButton(
                    icon: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Image.asset(
                        'assets/pola.png',
                        width: 110,
                        height: 60,
                      ),
                    ),
                    title: 'Tentang Pola Kuman', // Menggunakan string biasa
                    isCenter: true,
                    backgroundColor: const Color(0xFFFF9800),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Polakuman(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Bottom Info
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Color.fromARGB(255, 0, 174, 255),
                ),
                const SizedBox(width: 8),
                Text(
                  'Gunakan Web untuk membuka semua fitur',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Bottom Navigation Bar
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 155, 226),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(1, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Tombol Home dengan efek ripple
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainMenu(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  // Tombol Chat dengan efek ripple
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        // Aksi ketika tombol Chat diklik
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Tombol Assignment dengan efek ripple
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        // Aksi ketika tombol Assignment diklik
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.assignment_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Tombol Settings dengan efek ripple
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 0), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PengaturanPage(), // Navigasi ke LoginScreen
                            ),
                          );
                        }); // Aksi ketika tombol Settings diklik
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PressableButton extends StatefulWidget {
  final Widget icon;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;
  final bool isCenter;

  const PressableButton({
    super.key,
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
    this.isCenter = false,
  });

  @override
  _PressableButtonState createState() => _PressableButtonState();
}

class _PressableButtonState extends State<PressableButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onTap,
        onHighlightChanged: (isHighlighted) {
          setState(() {
            isPressed = isHighlighted;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isPressed
                ? widget.backgroundColor
                    .withOpacity(0.8) // Ubah opasitas saat ditekan
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isPressed
                ? [] // Tidak ada shadow saat ditekan
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
          ),
          child: Stack(
            children: [
              // Dalam shadow effect
              Positioned.fill(
                child: Container(),
              ),
              Column(
                mainAxisAlignment: widget.isCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.icon,
                  const SizedBox(height: 5),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
