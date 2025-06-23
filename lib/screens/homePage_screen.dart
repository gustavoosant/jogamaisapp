import 'package:flutter/material.dart';
import 'package:patoteiros/widgets/card_Evento_widget.dart';
import '../widgets/card_BotaoMini_widget.dart';
import '../widgets/card_Botao_widget.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF182B5C),
        title: const Text('Joga+', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
            constraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48
            ),
            padding: EdgeInsets.zero,
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
            constraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Próximos Eventos',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF151B34),
            ),
          ),
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
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF182B5C),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  // ação para ir à Home
                },
                constraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48
                ),
                padding: EdgeInsets.zero,
              ),
              IconButton(
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  // ação para ir à Agenda
                },
                constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48
                ),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 48), // espaço para o FAB
              IconButton(
                icon: const Icon(Icons.chat_outlined, color: Colors.white),
                onPressed: () {
                  // ação para ir ao Chat
                },
                constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48
                ),
                padding: EdgeInsets.zero,
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  // ação para ir ao Perfil
                },
                constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48
                ),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF151B34),
        child: const Icon(Icons.add_circle_outline, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
