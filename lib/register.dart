import 'package:flutter/material.dart';
import 'package:penicillisolver/login.dart';

void main() {
  runApp(const Landing());
}

// Penamaan kelas harus PascalCase
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
    // Menunggu 5 detik sebelum berpindah halaman
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration:
              const Duration(milliseconds: 600), // Durasi transisi
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Register(), // Pastikan class Register sudah ada
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
  bool _obscureText1 = true; // Untuk Kata Sandi
  bool _obscureText2 = true; // Untuk Konfirmasi Kata Sandi
  List<bool> isSelected = [true, false, false, false]; // Untuk pilihan tim

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(37, 160, 237, 1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(37, 160, 237, 1), width: 2),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(37, 160, 237, 1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(37, 160, 237, 1), width: 2),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(37, 160, 237, 1), width: 2),
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

              // Confirm Password Input Field
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
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(37, 160, 237, 1), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(37, 160, 237, 1), width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText2 = !_obscureText2; // Toggle visibility
                      });
                    },
                  ),
                ),
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
              ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol "Daftar" diklik
                },
                child: const Text('Daftar',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              const SizedBox(height: 20),

              // Sudah punya akun / Login dengan
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah Punya Akun ?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // TODO: Route ke LoginScreen
                    },
                    child: const Text(
                      'Masuk',
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
    );
  }
}
