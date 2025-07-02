import 'package:flutter/material.dart';
import 'package:jogamais/repositories/evento_repository.dart';
import 'package:jogamais/widgets/card_Evento_widget.dart';
import 'package:jogamais/widgets/fab_widget.dart';
import 'package:provider/provider.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() => isLoading = true);

    try {
      final eventoRepository = context.read<EventoRepository>();
      await eventoRepository.readEventos();

      // Buscar organizadores para cada evento
      for (var evento in eventoRepository.eventos) {
        final organizador = await eventoRepository.getOrganizadorPatota(
          evento['patota'],
        );
        evento['organizador'] = organizador;
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
      throw Exception('Erro ao carregar dados: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventoRepository>(
      builder: (context, eventoRepository, child) {
        final eventos = eventoRepository.eventos;

        return Scaffold(
          appBar: const CustomAppBar(),
          body: RefreshIndicator(
            color: Color(0xFF151B34),
            backgroundColor: const Color(0xFFB0B1C6),
            onRefresh: _carregarDados,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ScreenTitle(title: 'Próximos Eventos'),
                const SizedBox(height: 16),

                Container(
                  height:
                      eventos.length <= 2
                          ? null // Altura automática se 2 ou menos cards
                          : 360, // Altura fixa se mais de 2 cards
                  child:
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : eventos.isEmpty
                          ? Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.event_busy,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Nenhum evento encontrado',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : eventos.length <= 2
                          ? Column(
                            // Sem scroll para 2 ou menos cards
                            children:
                                eventos.map((evento) {
                                  return Column(
                                    children: [
                                      buildEventoCard(
                                        nomePatota: evento['patota'] ?? 'N/A',
                                        organizador:
                                            evento['organizador'] ?? 'N/A',
                                        descEvento:
                                            evento['descEvento'] ?? 'N/A',
                                        dataEvento:
                                            evento['dataEvento'] ?? 'N/A',
                                        horarioEvento:
                                            evento['horarioEvento'] ?? 'N/A',
                                        localEvento:
                                            '${evento['ruaEvento'] ?? ''}, ${evento['numeroEvento'] ?? ''}',
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  );
                                }).toList(),
                          )
                          : SingleChildScrollView(
                            // Com scroll para mais de 2 cards
                            child: Column(
                              children:
                                  eventos.map((evento) {
                                    return Column(
                                      children: [
                                        buildEventoCard(
                                          nomePatota: evento['patota'] ?? 'N/A',
                                          organizador:
                                              evento['organizador'] ?? 'N/A',
                                          descEvento:
                                              evento['descEvento'] ?? 'N/A',
                                          dataEvento:
                                              evento['dataEvento'] ?? 'N/A',
                                          horarioEvento:
                                              evento['horarioEvento'] ?? 'N/A',
                                          localEvento:
                                              '${evento['ruaEvento'] ?? ''}, ${evento['numeroEvento'] ?? ''}',
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    );
                                  }).toList(),
                            ),
                          ),
                ),

                const SizedBox(height: 20),
                buildBotaoCard(
                  icon: Icons.groups,
                  titulo: 'Patotas',
                  onTap: () {},
                ),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
