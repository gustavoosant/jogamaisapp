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
  late String toogleText;
  bool loading = false;

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
        toogleTextButton = 'Criar conta';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toogleTextButton = 'Voltar para o login';
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      isLogin
                          ? BorderRadius.only(topLeft: Radius.circular(40))
                          : BorderRadius.only(topRight: Radius.circular(40)),
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
                                      return 'Informe seu email';
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
                                if (isLogin)
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
