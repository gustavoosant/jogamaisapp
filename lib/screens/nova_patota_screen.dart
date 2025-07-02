import 'package:flutter/material.dart';
import 'package:jogamais/repositories/patota_repository.dart';
import 'package:jogamais/repositories/perfil_repository.dart';
import 'package:jogamais/widgets/custom_appbar_widget.dart';
import 'package:jogamais/widgets/screen_title_widget.dart';
import 'package:provider/provider.dart';

class NovaPatotaScreen extends StatefulWidget {
  const NovaPatotaScreen({super.key});

  @override
  State<NovaPatotaScreen> createState() => _NovaPatotaScreen();
}

class _NovaPatotaScreen extends State<NovaPatotaScreen> {
  final TextEditingController _patotaController = TextEditingController();
  int paginaAtual = 0;
  bool loading = false;

  _salvarPatotaInfo(organizador) async {
    final nomePatota = _patotaController.text;

    setState(() => loading = true);

    if (nomePatota.isNotEmpty && organizador.isNotEmpty) {
      try {
        final patotaInfos = Provider.of<PatotaRepository>(
          context,
          listen: false,
        );
        await patotaInfos.savePatotaInfos(nomePatota, organizador);

        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Patota salva com sucesso!'),
            backgroundColor: Color(0XFF1C5718),
          ),
        );
      } catch (e) {
        setState(() => loading = false);

        String mensagemErro;

        if (e.toString().contains('Usuário não autenticado')) {
          mensagemErro = 'Erro de autenticação. Faça login novamente.';
        } else if (e.toString().contains('Esta patota já está cadastrada')) {
          mensagemErro = 'Você já possui uma patota criada com este nome!';
        } else if (e.toString().contains('Erro ao salvar patota')) {
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
                  (nomeUsuario != null) ? nomeUsuario : 'Usuario',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF151B34),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),
          TextFormField(
            controller: _patotaController,
            decoration: InputDecoration(
              labelText: 'Nome da Patota',
              hintText: 'Digite o nome da Patota',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: Color(0xFF151B34), fontSize: 20),
              hintStyle: TextStyle(color: Color(0xFF151B34), fontSize: 14),
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
              onPressed: () => _salvarPatotaInfo(nomeUsuario),
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
    );
  }
}
