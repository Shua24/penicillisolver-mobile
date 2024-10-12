import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PenicilliSolver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // Updated to LoginScreen
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image of the logo
            Center(
              child: Image.asset(
                'assets/logo.png', // Change the path accordingly
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 30),
            // Title
            const Center(
              child: Text(
                'Masuk',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Email Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            // Password Input
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Forgot password functionality
                },
                child: const Text('Lupa Kata Sandi'),
              ),
            ),
            const SizedBox(height: 20),
            // Login Button
            ElevatedButton(
              onPressed: () {
                // Login functionality
              },
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.grey,
              //   padding: const EdgeInsets.symmetric(vertical: 15),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              // ),
              child: const Text(
                'Masuk',
                // style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            // Register
            const Center(
              child: Text('Belum Punya Akun ? Daftar'),
            ),
            const SizedBox(height: 10),
            // Social Media Login
            const Center(
              child: Text('Atau lanjutkan dengan :'),
            ),
            const SizedBox(height: 10),
            // Social Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google Icon
                IconButton(
                  icon: Image.asset('assets/logo_google.png',  width: 40, height: 40,),
                  iconSize: 20,
                  onPressed: () {
                    // Google login functionality
                  },
                ),
                const SizedBox(width: 20),
                // Facebook Icon
                IconButton(
                  icon: Image.asset('assets/logo_facebook.webp', width: 60, height: 60,),
                  iconSize: 20,
                  onPressed: () {
                    // Facebook login functionality
                  },
                ),
                const SizedBox(width: 20),
                // Twitter Icon
                IconButton(
                  icon: Image.asset('assets/logo_twitter.png', width: 40, height: 40,),
                  iconSize: 20,
                  onPressed: () {
                    // Twitter login functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
