import 'package:flutter/material.dart';
import 'package:penicillisolver/login.dart';
import 'theme.dart';
import 'register.dart';
// yang lain nanti di import, dipanggil konstruktornya (lihat KPL)

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Apply the theme
      home: const LoadingPage(),
      title: 'PenicilliSolver',
    );
  }
}
