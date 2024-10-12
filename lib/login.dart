import 'package:flutter/material.dart';
import 'package:penicillisolver/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PenicilliSolver',
      theme: AppTheme.lightTheme,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true; // Initially hide password

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
              obscureText: _obscureText, // Control visibility of password
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Toggle password visibility
                    });
                  },
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility, // Change icon based on visibility
                  ),
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
              child: const Text(
                'Masuk',
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
                  icon: Image.asset('assets/logo_google.png', width: 40, height: 40),
                  iconSize: 20,
                  onPressed: () {
                    // Google login functionality
                  },
                ),
                const SizedBox(width: 20),
                // Facebook Icon
                IconButton(
                  icon: Image.asset('assets/logo_facebook.webp', width: 60, height: 60),
                  iconSize: 20,
                  onPressed: () {
                    // Facebook login functionality
                  },
                ),
                const SizedBox(width: 20),
                // Twitter Icon
                IconButton(
                  icon: Image.asset('assets/logo_twitter.png', width: 40, height: 40),
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
