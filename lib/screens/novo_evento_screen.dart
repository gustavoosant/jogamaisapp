import 'package:flutter/material.dart';
import 'package:jogamais/repositories/evento_repository.dart';
import 'package:jogamais/repositories/patota_repository.dart';
import 'package:jogamais/screens/drawer_screen.dart';
import 'package:jogamais/widgets/custom_appbar_widget.dart';
import 'package:jogamais/widgets/screen_title_widget.dart';
import 'package:provider/provider.dart';

class NovoEventoScreen extends StatefulWidget {
  const NovoEventoScreen({super.key});

  @override
  State<NovoEventoScreen> createState() => _NovoEventoScreen();
}

class _NovoEventoScreen extends State<NovoEventoScreen> {
  String? patotaSelecionada;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  DateTime? dataSelecionada;
  final TextEditingController _horarioController = TextEditingController();
  final TextEditingController _descEventoController = TextEditingController();
  final TextEditingController _localRuaController = TextEditingController();
  final TextEditingController _localNumeroController = TextEditingController();
  final TextEditingController _localCEPController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selecionarData() async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      locale: const Locale('pt', 'BR'),
    );

    if (dataEscolhida != null) {
      setState(() {
        dataSelecionada = dataEscolhida;
      });
    }
  }

  Future<void> _selecionarHorario() async {
    final TimeOfDay? horarioEscolhido = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horarioEscolhido != null) {
      setState(() {
        _horarioController.text =
            '${horarioEscolhido.hour.toString().padLeft(2, '0')}:${horarioEscolhido.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  _salvarEventoInfo() async {
    final horarioEvento = _horarioController.text;
    final dataEvento = dataSelecionada;
    final patotaEvento = patotaSelecionada;
    final descEvento = _descEventoController.text;
    final ruaEvento = _localRuaController.text;
    final numeroEvento = _localNumeroController.text;
    final cepEvento = _localCEPController.text;

    setState(() => loading = true);

    if (horarioEvento.isNotEmpty &&
        dataEvento != null &&
        patotaEvento!.isNotEmpty &&
        descEvento.isNotEmpty &&
        ruaEvento.isNotEmpty &&
        numeroEvento.isNotEmpty &&
        cepEvento.isNotEmpty) {
      try {
        final dataEventoFinal =
            "${dataEvento!.day.toString().padLeft(2, '0')}/${dataEvento!.month.toString().padLeft(2, '0')}/${dataEvento!.year}";

        final patotaInfos = Provider.of<EventoRepository>(
          context,
          listen: false,
        );
        await patotaInfos.saveEventoInfos(
          patotaEvento!,
          horarioEvento,
          dataEventoFinal,
          descEvento,
          ruaEvento,
          numeroEvento,
          cepEvento,
        );

        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Evento salvo com sucesso!'),
            backgroundColor: Color(0XFF1C5718),
          ),
        );
      } catch (e) {
        setState(() => loading = false);

        String mensagemErro;
        if (e.toString().contains('Erro ao salvar patota')) {
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
    return Consumer<PatotaRepository>(
      builder: (context, patotaRepository, child) {
        final patotas = patotaRepository.patotas;
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
                    value: patotaSelecionada,
                    items:
                        patotas.isEmpty
                            ? [
                              DropdownMenuItem(
                                value: null,
                                child: Text(
                                  'Nenhuma patota criada',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ]
                            : patotas
                                .map(
                                  (patota) => DropdownMenuItem(
                                    value: patota,
                                    child: Text(patota),
                                  ),
                                )
                                .toList(),
                    onChanged:
                        patotas.isEmpty
                            ? null
                            : (value) {
                              setState(() {
                                patotaSelecionada = value;
                              });
                            },
                    hint: Text('Nome da patota', style: hintStyle),
                  ),
                  (patotas.isEmpty)
                      ? SizedBox.shrink()
                      : const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Descrição do Evento", style: labelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descEventoController,
                        decoration: inputDecoration.copyWith(
                          hintText: 'Digite o tipo do Evento',
                          hintStyle: hintStyle,
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
                                  onPressed: _selecionarData,
                                  style: outlinedButtonStyle,
                                  child: SizedBox(
                                    width: 102,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        dataSelecionada != null
                                            ? Text(
                                              "${dataSelecionada!.day.toString().padLeft(2, '0')}/${dataSelecionada!.month.toString().padLeft(2, '0')}/${dataSelecionada!.year}",
                                              style: TextStyle(
                                                color: Color(0xFF151B34),
                                                fontSize: 14,
                                              ),
                                            )
                                            : Text("Data", style: hintStyle),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF151B34),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Horário", style: labelStyle),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 40,
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: _selecionarHorario,
                                    style: outlinedButtonStyle,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _horarioController.text.isNotEmpty
                                            ? Text(
                                              _horarioController.text,
                                              style: TextStyle(
                                                color: Color(0xFF151B34),
                                                fontSize: 14,
                                              ),
                                            )
                                            : Text("00:00", style: hintStyle),
                                        const SizedBox(width: 10),
                                        Icon(
                                          Icons.schedule,
                                          color: Color(0xFF151B34),
                                        ),
                                      ],
                                    ),
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
                      Text("Nome da rua", style: subLabelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _localRuaController,
                        decoration: inputDecoration.copyWith(
                          hintText: "Digite o nome da rua",
                          hintStyle: hintStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text("Número", style: subLabelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _localNumeroController,
                        decoration: inputDecoration.copyWith(
                          hintText: "Digite o número",
                          hintStyle: hintStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text("CEP", style: subLabelStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _localCEPController,
                        decoration: inputDecoration.copyWith(
                          hintText: "Digite o CEP",
                          hintStyle: hintStyle,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => _salvarEventoInfo(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF172348),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
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
                                    : Text(
                                      "Salvar",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ],
              ),
            ),
          ),
          endDrawer: const TelaMenuDrawer(),
        );
      },
    );
  }

  final inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Color(0xFF151B34)),
    ),
  );

  final labelStyle = TextStyle(
    color: Color(0xFF151B34),
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  final subLabelStyle = TextStyle(
    color: Color(0xFF151B34),
    fontSize: 14,
    fontWeight: FontWeight.w400,
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
