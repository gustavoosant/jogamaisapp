import 'package:flutter/material.dart';
import 'package:jogamais/services/auth_service.dart';
import 'package:jogamais/widgets/screenTitle_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/customAppBar_widget.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _usuarioController.dispose();
    super.dispose();
  }

  void _salvarPerfil() {
    final nome = _nomeController.text;
    final sobrenome = _sobrenomeController.text;
    final usuario = _usuarioController.text;

    // Aqui você pode salvar os dados, fazer validações, etc.
    print('Nome: $nome\nSobrenome: $sobrenome\nUsuário: $usuario');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(title: 'Perfil', showBack: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: const Color(0xFF666A90),
                    child: Icon(Icons.person, size: 75, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB0B1C6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.25),
                    ),
                    onPressed: () {
                      // Lógica para editar a foto/perfil
                    },
                    child: const Text(
                      'Editar',
                      style: TextStyle(
                        color: Color(0xFF151B34),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CampoTexto(
                    label: 'Nome',
                    hint: 'Digite seu nome',
                    controller: _nomeController,
                  ),
                  const SizedBox(height: 24),
                  CampoTexto(
                    label: 'Sobrenome',
                    hint: 'Digite seu sobrenome',
                    controller: _sobrenomeController,
                  ),
                  const SizedBox(height: 24),
                  CampoTexto(
                    label: 'Nome de usuário',
                    hint: 'Digite seu usuário',
                    controller: _usuarioController,
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF172348),
                        elevation: 6,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: _salvarPerfil,
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFFFFF),
                        surfaceTintColor: const Color(0xFFFF0000),
                        elevation: 6,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () => context.read<AuthService>().logout(),
                      child: const Text(
                        'Sair',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF751313),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CampoTexto extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const CampoTexto({
    required this.label,
    required this.hint,
    required this.controller,
    super.key,
  });

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFF151B34)),
        ),
      ),
    );
  }
}
