// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:penicillisolver/login.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const Landing());
}

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingPage(),
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
            Image.asset('assets/logo2.png'),
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
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  List<bool> isSelected = [true, false, false, false];

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
                        _obscureText1 = !_obscureText1; // mata
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // konfirmasi kata sandi
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

              const SizedBox(height: 20),

              // Pilihan Tim (Mikrobiologi, Dokter, PPI, PPRA)
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Daftar Sebagai Tim:',
                  style: TextStyle(
                    color: Color.fromRGBO(37, 160, 237, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              ToggleButtons(
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                isSelected: isSelected,
                color: const Color.fromARGB(255, 0, 0, 0),
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                children: const <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
                    child: Text('Mikrobiologi'),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
                    child: Text('Dokter'),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
                    child: Text('PPI'),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
                    child: Text('PPRA'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Tombol Daftar
              SizedBox(
                width: 400,
                height: 50, // Mengatur lebar tombol
                child: ElevatedButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    });
                    // Aksi ketika tombol ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Mengatur warna latar belakang tombol
                    foregroundColor: Colors.white, // Mengatur warna teks tombol
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 17), // Mengatur ukuran teks
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sudah punya akun / Login dengan
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sudah Punya Akun ?',
                    style:
                        TextStyle(fontSize: 17), // Ukuran teks untuk pertanyaan
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // Menavigasi ke LoginScreen setelah penundaan
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LoginScreen(), // Navigasi ke LoginScreen
                          ),
                        );
                      });
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        color: Color.fromRGBO(37, 160, 237, 1), // Warna teks
                        fontWeight: FontWeight.bold, // Teks tebal
                        fontSize: 17, // Ukuran teks
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Text(
                'Atau Lanjutkan Dengan :',
                style: TextStyle(fontSize: 15), // Ukuran teks untuk pertanyaan
              ),
              const SizedBox(height: 10),

              // Tombol Sosial Media (Google, Facebook, Twitter)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol Google
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
                  // Tombol Facebook
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
                  // Tombol Twitter
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
