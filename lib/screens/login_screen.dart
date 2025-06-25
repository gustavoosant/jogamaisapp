import 'package:flutter/material.dart';
import 'package:jogamais/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toogleTextButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }


  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Login';
        actionButton = 'Login';
        toogleTextButton = 'Não possui uma conta? Criar conta';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toogleTextButton = 'Voltar para o login';
      }
    });
  }

  login() async {
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async{
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF182B5C),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Logo
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 128,
                height: 128,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Joga+',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            // Área branca expandida
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Conteúdo superior (formulário)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  titulo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF151B34),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                TextFormField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                    labelText: 'E-mail',
                                    hintText: 'Digite seu e-mail',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Informe o email corretamente';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: senha,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Senha',
                                    hintText: 'Digite sua senha',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Informe sua senha';
                                    } else if (value.length < 6) {
                                      return 'Sua senha deve possui no mínimo 6 carcteres';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Esqueceu a senha?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF626262),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF172348),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    elevation: 4,
                                    shadowColor: Colors.black38,
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (isLogin) {
                                        login();
                                      } else {
                                        registrar();
                                      }
                                    }
                                  },
                                  child: Text(
                                    actionButton,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Rodapé (fixado no final da área branca)
                            Column(
                              children: [
                                const SizedBox(height: 32),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => setFormAction(!isLogin),
                                      child: Text(
                                        toogleTextButton,
                                        style: TextStyle(
                                          color: Color(0xFF151B34),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
