import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:jogamais/repositories/perfil_repository.dart';
import 'package:jogamais/screens/perfil_screen.dart';
import 'package:jogamais/widgets/custom_appbar_widget.dart';
import 'package:jogamais/widgets/custom_bottombar_widget.dart';
import 'package:jogamais/widgets/screen_title_widget.dart';
import 'package:provider/provider.dart';

class NovaPatotaScreen extends StatefulWidget {
  const NovaPatotaScreen({super.key});

  @override
  State<NovaPatotaScreen> createState() => _NovaPatotaScreen();
}

class _NovaPatotaScreen extends State<NovaPatotaScreen> {
  int paginaAtual = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final nomeUsuario = context.watch<PerfilRepository>().nome;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: 'Nova Patota', showBack: true),
          SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Organizador',
                style: TextStyle(
                  color: Color(0xFF151B34),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFB0B1C6),
                  border: Border.all(color: Color(0xFF151B34)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  nomeUsuario!,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nome da Patota',
              hintText: 'Digite o nome da Patota',
              labelStyle: TextStyle(color: Color(0xFF151B34), fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Color(0xFF151B34)),
              ),
            ),
          ),
          SizedBox(height: 60),
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
              onPressed: () {},
              child:
                  (loading)
                      ? Padding(
                        padding: EdgeInsets.all(8),
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                      : const Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF172348),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 4,
                shadowColor: Color(0x26000000),
              ),
              icon: Icon(Icons.share, size: 24, color: Colors.white),
              label: Text(
                'Compartilhar',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      color: Color(0x26000000),
                    ),
                  ],
                ),
              ),
              onPressed: null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: paginaAtual,
        onTap: (index) async {
          setState(() {
            paginaAtual = index;
          });

          if (index == 3) {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PerfilScreen()),
            );
            setState(() {
              paginaAtual = 0;
            });
          }
        },
      ),

      floatingActionButton: SpeedDial(
        icon: Icons.add_circle_outline,
        activeIcon: Icons.close_outlined,
        backgroundColor: const Color(0xFF151B34),
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        buttonSize: Size(60.0, 60.0),
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color(0xFFB0B1C6),
            foregroundColor: Colors.white,
            label: 'Criar novo Evento',
            labelStyle: TextStyle(
              color: Color(0xFF151B34),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            labelBackgroundColor: const Color(0xFFB0B1C6),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NovaPatotaScreen(),
                  ),
                ),
          ),
          SpeedDialChild(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color(0xFFB0B1C6),
            foregroundColor: Colors.white,
            label: 'Criar nova Patota',
            labelStyle: TextStyle(
              color: Color(0xFF151B34),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            labelBackgroundColor: const Color(0xFFB0B1C6),
            onTap: () => print('Mensagem'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
