import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PenicilliSolver'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('A quick brown fox jumps over the lazy dog'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  const Text('');
                },
                child: const Text('Cari'),
              )
            ],
          ),
        ));
  }
}
