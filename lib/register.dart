// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_import, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:penicillisolver/login.dart';
import 'package:penicillisolver/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const Landing());
}

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Register(),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo2.png',
              width: 333,
              height: 333,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _sipController = TextEditingController();
  final ValueNotifier<String?> selectedTeamNotifier =
      ValueNotifier<String?>(null);

  final TextEditingController teamController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  List<bool> isSelected = [true, false, false, false];

  @override
  void dispose() {
    selectedTeamNotifier.dispose();
    teamController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    // Memeriksa apakah semua field diisi
    if (_namaController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _sipController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    String password = _passwordController.text;
    if (!_isPasswordValid(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi harus minimal 6 karakter, '
              'mengandung huruf besar, huruf kecil, dan angka.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Memeriksa apakah kata sandi dan konfirmasi kata sandi cocok
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kata sandi dan konfirmasi sandi tidak cocok'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Memeriksa apakah tim telah dipilih
    if (selectedTeamNotifier.value == null ||
        selectedTeamNotifier.value!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tim terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    // Validasi kata sandi

    return true;
  }

// Fungsi untuk memvalidasi kata sandi
  bool _isPasswordValid(String password) {
    // Memeriksa panjang kata sandi
    if (password.length < 6) return false;

    // Memeriksa keberadaan huruf besar, huruf kecil, dan angka
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));

    return hasUppercase && hasLowercase && hasDigits;
  }

  Future<void> _registerUser() async {
    if (!_validateInputs()) {
      return;
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user?.uid)
            .set({
          'uid': credential.user?.uid,
          'nama': _namaController.text.trim(),
          'email': _emailController.text.trim(),
          'sip': _sipController.text.trim(),
          'role': selectedTeamNotifier.value,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print("Data berhasil disimpan ke Firestore.");

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registrasi berhasil!'),
                backgroundColor: Colors.green),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } catch (firestoreError) {
        print("Error saat menyimpan ke Firestore: $firestoreError");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Terjadi kesalahan saat menyimpan data. $firestoreError'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print("General Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan. Coba lagi.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Daftar',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: 170,
                  height: 125,
                  child: Image.asset(
                    'assets/logo1.png',
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Nama
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama',
                  style: TextStyle(
                    color: Color.fromRGBO(37, 160, 237, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: 'Nama anda',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1), // saat fokus
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Email
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
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email anda',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1), // saat fokus
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nomor SIP',
                  style: TextStyle(
                    color: Color.fromRGBO(37, 160, 237, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _sipController,
                decoration: InputDecoration(
                  hintText: 'Nomor SIP',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // kata sandi
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
                controller: _passwordController,
                obscureText: _obscureText1,
                decoration: InputDecoration(
                  hintText: 'Kata Sandi Anda',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
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
                        _obscureText1 = !_obscureText1;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Konfirmasi Kata Sandi',
                  style: TextStyle(
                    color: Color.fromRGBO(37, 160, 237, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureText2,
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Kata Sandi',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 170, 170, 170)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(37, 160, 237, 1),
                      width: 2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),

              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Masuk Sebagai Tim',
                  style: TextStyle(
                    color: Color.fromRGBO(37, 160, 237, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ValueListenableBuilder<String?>(
                valueListenable: selectedTeamNotifier,
                builder: (context, selectedTeam, _) {
                  return DropdownButtonFormField<String>(
                    value: selectedTeam,
                    items: [
                      "Pilih Tim",
                      "Mikrobiologi",
                      "Dokter",
                      "PPI",
                      "PPRA",
                      "Penanggung Jawab Lab"
                    ].map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedTeamNotifier.value = value;
                    },
                  );
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: 400,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    await _registerUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah Punya Akun ?',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      });
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        color: Color.fromRGBO(37, 160, 237, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Text(
                'Atau Lanjutkan Dengan :',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/google.png',
                      width: 50,
                      height: 50,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      _launchURL('https://www.google.com');
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Image.asset(
                      'assets/fb.png',
                      width: 40,
                      height: 40,
                    ),
                    iconSize: 30,
                    onPressed: () {
                      _launchURL('https://www.facebook.com');
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      icon: Image.asset(
                        'assets/x.png',
                        width: 40,
                        height: 40,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        _launchURL('https://www.twitter.com');
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
