import 'package:flutter/material.dart';
import 'package:jogamais/repositories/perfil_repository.dart';
import 'package:jogamais/screens/perfil_screen.dart';
import 'package:provider/provider.dart';

class TelaMenuDrawer extends StatelessWidget {
  const TelaMenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<PerfilRepository>(
        builder: (context, perfilRepository, child) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.menu, size: 30),
                ),
                SizedBox(height: 16),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF666A90),
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  perfilRepository.nome?.isNotEmpty == true
                      ? perfilRepository.nome!
                      : 'Usuário',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF151B34),
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFB0B1C6),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Color(0x4C000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Color(0xFF151B34)),
                    title: Text(
                      'Perfil',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF151B34),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PerfilScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Spacer(),
                SizedBox(height: 16),
                Image.asset(
                  'assets/images/logo_2.png',
                  width: 150,
                  height: 150,
                ),
                Text(
                  'Joga+',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF151B34),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
