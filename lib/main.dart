import 'package:flutter/material.dart';
import 'package:socialhub/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to our social App',
      home: HomeScreen(),
    );
  }
}

