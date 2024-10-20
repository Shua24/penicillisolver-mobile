// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'package:penicillisolver/PengaturanAkun.dart';
import 'package:penicillisolver/login.dart';
import 'package:penicillisolver/lookup.dart';
import 'package:penicillisolver/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const PengaturanPage(),
    );
  }
}

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  _PengaturanPageState createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  final List<bool> _isPressed = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
                            builder: (context) => const MainMenu()),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Text(
                        'Pengaturan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    child: Icon(Icons.person,
                        size: 40, color: Color.fromARGB(0, 255, 255, 255)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/user1.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Joshua',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView(
                  children: [
                    _buildMenuItem(0, Icons.person, 'Pengaturan Akun',
                        onTap: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PengaturanAkun()), // Tanda const ditambahkan jika perlu
                        );
                      });
                    }),
                    _buildMenuItem(1, Icons.lock, 'Hak Akses', onTap: () {}),
                    _buildMenuItem(2, Icons.chat, 'Chat', onTap: () {}),
                    _buildMenuItem(3, Icons.notifications, 'Notifikasi',
                        onTap: () {}),
                    _buildMenuItem(4, Icons.language, 'Bahasa', onTap: () {}),
                    _buildMenuItem(5, Icons.help_outline, 'Bantuan',
                        onTap: () {}),
                    _buildMenuItem(6, Icons.exit_to_app, 'Keluar Akun',
                        onTap: () {
                      _showLogoutConfirmation(context);
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Version: 1.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
            // Tombol Assignment dengan efek ripple
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AntibioticQuery(),
                    ),
                  );
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
                        builder: (context) => const PengaturanPage(),
                      ),
                    );
                  });
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
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String title,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed[index] = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed[index] = false;
        });
        if (onTap != null) {
          onTap();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed[index] = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: const Color.fromARGB(255, 0, 155, 226)),
            boxShadow: _isPressed[index]
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Warna bayangan
                      spreadRadius: 2, // Jarak bayangan
                      blurRadius: 5, // Tingkat kabur bayangan
                      offset: const Offset(0, 3), // Arah bayangan
                    ),
                  ],
          ),
          child: ListTile(
            leading: Icon(icon, color: const Color.fromARGB(255, 0, 155, 226)),
            title: Text(title),
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Anda yakin ingin keluar dari akun?'),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                });
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
