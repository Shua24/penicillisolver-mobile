import 'package:flutter/material.dart';
import 'theme.dart'; // import your theme file
import 'register.dart'; // import the registration page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Apply the theme
      home:
          RegistrationPage(), // Set the registration page as the initial route
    );
  }
}
