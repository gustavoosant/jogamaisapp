import 'package:flutter/material.dart';
import 'package:jogamais/screens/drawer_screen.dart';
import 'package:jogamais/services/auth_service.dart';
import 'package:jogamais/widgets/campo_texto_widget.dart';
import 'package:jogamais/widgets/screen_title_widget.dart';
import 'package:provider/provider.dart';
import 'package:jogamais/repositories/perfil_repository.dart';

import '../widgets/custom_appbar_widget.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  bool loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final perfilRepository = Provider.of<PerfilRepository>(
      context,
      listen: false,
    );
    if (perfilRepository.nome != null && _nomeController.text.isEmpty) {
      _carregarDadosPerfil(perfilRepository);
    }
  }

  _salvarPerfil() async {
    final nome = _nomeController.text;
    final sobrenome = _sobrenomeController.text;
    final usuario = _usuarioController.text;

    setState(() => loading = true);

    if (nome.isNotEmpty && sobrenome.isNotEmpty && usuario.isNotEmpty) {
      try {
        final perfilInfos = Provider.of<PerfilRepository>(
          context,
          listen: false,
        );
        await perfilInfos.savePerfilInfos(nome, sobrenome, usuario);

        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil salvo com sucesso!'),
            backgroundColor: Color(0XFF1C5718),
          ),
        );
      } catch (e) {
        setState(() => loading = false);

        String mensagemErro;

        // Tratar erros específicos da função savePerfilInfos
        if (e.toString().contains('Usuário não autenticado')) {
          mensagemErro = 'Erro de autenticação. Faça login novamente.';
        } else if (e.toString().contains(
          'Este nome de usuário já está em uso',
        )) {
          mensagemErro =
              'Este nome de usuário já está sendo usado por outro usuário.';
        } else if (e.toString().contains('Você já possui um perfil criado')) {
          mensagemErro =
              'Você já possui um perfil. As informações foram atualizadas.';
        } else if (e.toString().contains('Erro ao salvar perfil')) {
          mensagemErro = 'Erro interno. Tente novamente.';
        } else {
          mensagemErro = 'Erro inesperado: $e';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(mensagemErro),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } else {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos!'),
          backgroundColor: Color(0xFF8F3509),
        ),
      );
    }
  }

  void _carregarDadosPerfil(PerfilRepository perfilRepository) {
    if (perfilRepository.nome != null &&
        perfilRepository.sobrenome != null &&
        perfilRepository.usuario != null) {
      _nomeController.text = perfilRepository.nome!;
      _sobrenomeController.text = perfilRepository.sobrenome!;
      _usuarioController.text = perfilRepository.usuario!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Consumer<PerfilRepository>(
        builder: (context, perfilRepository, child) {
          if (perfilRepository.nome != null && _nomeController.text.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _carregarDadosPerfil(perfilRepository);
            });
          }
          return ListView(
            children: [
              ScreenTitle(title: 'Perfil', showBack: true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 75,
                              backgroundColor: const Color(0xFF666A90),
                              child: Icon(
                                Icons.person,
                                size: 75,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF172348),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 34,
                      width: 160,
                      child: Text(
                        perfilRepository.nome?.isNotEmpty == true
                            ? perfilRepository.nome!
                            : _nomeController.text,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF151B34),
                        ),
                        textAlign: TextAlign.center,
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
                        onPressed: () => _salvarPerfil(),
                        child:
                            (loading)
                                ? Padding(
                                  padding: EdgeInsets.all(8),
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
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
                        onPressed: () async {
                          await context.read<AuthService>().logout();
                          Navigator.of(context).pop();
                        },
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
          );
        },
      ),
      endDrawer: const TelaMenuDrawer(),
    );
  }
}
