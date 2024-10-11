import 'package:flutter/material.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
    );
  }
}

class AntibioticQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari berdasarkan Pola Kuman'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Cari antibiotik berdasarkan pola kuman'),
            const SizedBox(height: 20),
            const SizedBox(
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pastikan bakteri ada pada pola kuman',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                const Text('');
              },
              child: const Text('Cari'),
            ),
          ],
        ),
      ),
    );
  }
}
