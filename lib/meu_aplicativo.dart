import 'package:flutter/material.dart';
import 'package:jogamais/widgets/auth_check.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joga+',
      debugShowCheckedModeBanner: false,
      home: const AuthCheck(),
    );
  }
}
