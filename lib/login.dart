// ignore_for_file: deprecated_member_use, use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'package:penicillisolver/lupa.dart';
import 'package:penicillisolver/register.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Register());
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool _obscureText1 = true;
  List<bool> isSelected = [true, false, false, false];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Format email tidak valid'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainMenu()),
      );
    } on FirebaseAuthException catch (e) {
      // Tangani berbagai error spesifik dari Firebase
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Email atau Password salah. Coba lagi.';
          break;
        default:
          errorMessage = 'Hmmm... Ada yg tidak sesuai kayaknya (${e.code}).';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login gagal: ${e.toString()}'),
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
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 56),
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
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                        color: Color.fromRGBO(37, 160, 237, 1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
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
                const SizedBox(height: 35),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _loginUser, // Pastikan fungsi ini dipanggil.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const Lupa()),
                          );
                        });
                      },
                      child: const Text(
                        'Lupa Kata Sandi ?',
                        style: TextStyle(
                          color: Color.fromRGBO(37, 160, 237, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
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
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          );
                        });
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: Color.fromRGBO(37, 160, 237, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Atau Lanjutkan Dengan :',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
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
                      },
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
