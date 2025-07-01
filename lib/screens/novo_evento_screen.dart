import 'package:flutter/material.dart';
import 'package:jogamais/screens/drawer_screen.dart';
import 'package:jogamais/widgets/custom_appbar_widget.dart';
import 'package:jogamais/widgets/screen_title_widget.dart';

class NovoEventoScreen extends StatefulWidget {
  const NovoEventoScreen({super.key});

  @override
  State<NovoEventoScreen> createState() => _NovoEventoScreen();
}

class _NovoEventoScreen extends State<NovoEventoScreen> {
  final List<String> patotas = ['Patota A', 'Patota B'];
  final _formKey = GlobalKey<FormState>();
  int paginaAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(title: 'Novo Evento', showBack: true),
              const SizedBox(height: 24),
              Text("Selecione a patota", style: labelStyle),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: inputDecoration,
                items:
                    patotas
                        .map(
                          (patota) => DropdownMenuItem(
                            value: patota,
                            child: Text(patota),
                          ),
                        )
                        .toList(),
                onChanged: (value) {},
                hint: Text('Nome da patota', style: hintStyle),
              ),
              const SizedBox(height: 24),
              Text("Descrição do Evento", style: labelStyle),
              const SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration.copyWith(
                  hintText: 'Digite o nome da Patota',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data", style: labelStyle),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: outlinedButtonStyle,
                          child: Text("Data", style: hintStyle),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Horário", style: labelStyle),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: inputDecoration.copyWith(
                            hintText: '00:00',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text("Local", style: labelStyle),
              const SizedBox(height: 16),
              Text("Nome da rua", style: labelStyle),
              const SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration.copyWith(
                  hintText: "Digite o nome da rua",
                ),
              ),
              const SizedBox(height: 16),
              Text("Número", style: labelStyle),
              const SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration.copyWith(
                  hintText: "Digite o número",
                ),
              ),
              const SizedBox(height: 16),
              Text("CEP", style: labelStyle),
              const SizedBox(height: 8),
              TextFormField(
                decoration: inputDecoration.copyWith(hintText: "Digite o CEP"),
              ),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF172348),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Salvar",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      endDrawer: const TelaMenuDrawer(),
    );
  }

  final inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF151B34)),
    ),
  );

  final labelStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  final hintStyle = TextStyle(color: Color(0xFFB1B1B1), fontSize: 14);

  final outlinedButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    side: BorderSide(color: Color(0xFF151B34)),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
