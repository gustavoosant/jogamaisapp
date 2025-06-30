import 'package:flutter/material.dart';
import 'package:jogamais/screens/login_screen.dart';
import 'package:jogamais/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../screens/home_page_screen.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return LoginScreen();
    } else {
      return HomePageScreen();
    }
  }

  loading() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
