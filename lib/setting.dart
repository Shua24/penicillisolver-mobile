import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'package:penicillisolver/pengaturan_akun.dart';
import 'package:penicillisolver/login.dart';
import 'package:penicillisolver/lookup.dart';
import 'package:penicillisolver/theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  String? namaPengguna;
  bool isLoading = true;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _ambilNamaPengguna();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _ambilNamaPengguna() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;

        final docSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        setState(() {
          namaPengguna = docSnapshot.get('nama');
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        namaPengguna = "Nama tidak ditemukan";
        isLoading = false;
      });

      print('Error mengambil nama pengguna: $e');
    }
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          namaPengguna ?? 'Nama tidak ditemukan',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
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
          _buildBottomNavButton(
              Icons.assignment_outlined, const AntibioticQuery()),
          _buildBottomNavButton(
              Icons.settings_outlined, const PengaturanPage()),
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
            leading: Icon(icon,
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
              'Apakah Anda yakin ingin menghapus akun ini? Semua data Anda akan dihapus secara permanen.'),
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
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    String uid = user.uid;

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .delete();

                    await user.delete();

                    _showSuccessNotification(namaPengguna);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  }
                } catch (e) {
                  if (e.toString().contains('requires-recent-login')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Sesi login Anda telah kedaluwarsa. Harap login ulang untuk menghapus akun.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessNotification(String? nama) async {
    final String username = nama ?? 'Pengguna';

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'delete_account_channel',
      'Delete Account',
      channelDescription: 'Notification when account is deleted',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Peringatan !',
      'Akun $username telah dihapus.',
      platformChannelSpecifics,
    );
  }

  Future<String?> _getPasswordFromUser(BuildContext context) async {
    TextEditingController passwordController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Password'),
          content: TextField(
            controller: passwordController,
            decoration:
                const InputDecoration(labelText: 'Masukkan password Anda'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, passwordController.text);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}