import 'package:flutter/material.dart';
import 'package:jogamais/meu_aplicativo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jogamais/services/auth_service.dart';
import 'configs/firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService())
      ],
        child: MeuAplicativo()
    ),
  );
}

