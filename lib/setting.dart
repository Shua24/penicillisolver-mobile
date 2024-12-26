import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan import Firebase
import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'package:penicillisolver/pengaturan_akun.dart';
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: Text(
                  'Joshua',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                            builder: (context) => const PengaturanAkun(),
                          ),
                        );
                      });
                    }),
                    _buildMenuItem(1, Icons.exit_to_app, 'Keluar Akun',
                        onTap: () {
                      _showLogoutConfirmation(context);
                    }),
                    _buildMenuItem(
                      2,
                      Icons.delete_forever_outlined,
                      'Hapus Akun',
                      onTap: () {
                        _showDeleteAccountConfirmation(context);
                      },
                      iconColor: Colors.red,
                      backgroundColor: Colors.red.shade100,
                    ),
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
          _buildBottomNavButton(Icons.home_outlined, const MainMenu()),
          _buildBottomNavButton(Icons.assignment_outlined, const AntibioticQuery()),
          _buildBottomNavButton(Icons.settings_outlined, const PengaturanPage()),
        ],
      ),
    );
  }

  Widget _buildBottomNavButton(IconData icon, Widget page) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String title,
      {VoidCallback? onTap, Color? iconColor, Color? backgroundColor}) {
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
            color: backgroundColor ?? Colors.white,
            border: Border.all(
              color: iconColor ?? const Color.fromARGB(255, 0, 155, 226)),
            boxShadow: _isPressed[index]
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: ListTile(
            leading: Icon(
              icon, 
              color: iconColor ?? const Color.fromARGB(255, 0, 155, 226)),
            title: Text(
              title,
              style: TextStyle(color: iconColor ?? Colors.black),
              ),
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

  void _showDeleteAccountConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus Akun'),
          content: const Text(
              'Apakah Anda yakin ingin menghapus akun ini?'),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.currentUser?.delete();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
