import 'package:flutter/material.dart';
import 'package:jogamais/widgets/card_Evento_widget.dart';
import 'package:jogamais/widgets/fab_widget.dart';
import '../widgets/card_BotaoMini_widget.dart';
import '../widgets/card_Botao_widget.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_bottombar_widget.dart';
import '../widgets/screen_title_widget.dart';
import 'perfil_screen.dart';
import 'package:jogamais/screens/drawer_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int paginaAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: 'Próximos Eventos'),
          const SizedBox(height: 16),
          buildEventoCard(
            nomePatota: 'Patota 1',
            organizador: 'Usuário 1',
            descricao: 'Jogo',
            data: '13/05',
            horario: '18:30',
            local: 'Soccer',
            confirmados: 12,
          ),
          const SizedBox(height: 8),
          buildEventoCard(
            nomePatota: 'Patota 2',
            organizador: 'Usuário 1',
            descricao: 'Confra Churrasco',
            data: '13/05',
            horario: '19:30',
            local: 'Soccer',
            confirmados: 12,
          ),
          const SizedBox(height: 30),
          buildBotaoCard(icon: Icons.groups, titulo: 'Patotas', onTap: () {}),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: buildBotaoMiniCard(
                  icon: Icons.emoji_events,
                  titulo: 'Leaderboard',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: buildBotaoMiniCard(
                  icon: Icons.photo_library,
                  titulo: 'Galeria',
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 100), // Espaço para a navbar
        ],
      ),
      endDrawer: const TelaMenuDrawer(),
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

      floatingActionButton: CustomFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
