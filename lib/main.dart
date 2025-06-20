import 'package:flutter/material.dart';
import 'package:patoteiros/screens/login_screen.dart';


void main() {
  runApp(const JogaApp());
}

class JogaApp extends StatelessWidget {
  const JogaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joga+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
