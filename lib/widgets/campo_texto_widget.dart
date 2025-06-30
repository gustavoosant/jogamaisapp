import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  const CampoTexto({
    required this.label,
    required this.hint,
    required this.controller,
    super.key,
  });

  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: const TextStyle(color: Color(0xFF151B34)),
        hintStyle: const TextStyle(color: Color(0xFFB1B1B1), fontSize: 12),
        border: OutlineInputBorder(),
      ),
    );
  }
}
