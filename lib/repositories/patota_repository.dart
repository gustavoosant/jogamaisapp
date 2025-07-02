import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jogamais/databases/db_firestore.dart';
import 'package:jogamais/services/auth_service.dart';

class PatotaRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;
  final List<String> _listaPatotas = [];

  List<String> get patotas => _listaPatotas;

  PatotaRepository({required this.auth}) {
    _startRepository();
    if (auth.usuario != null) {
      readPatotas();
    }
  }

  _startRepository() async {
    await _startFirestore();
    await readPatotas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future<void> readPatotas() async {
    if (auth.usuario != null) {
      try {
        final patotasUsuario =
            await db
                .collection('patotasUsuario/${auth.usuario!.uid}/patota')
                .get();

        _listaPatotas.clear();
        for (var doc in patotasUsuario.docs) {
          final infosPatota = doc.data();
          if (infosPatota['patota'] != null) {
            _listaPatotas.add(infosPatota['patota']);
          }
        }
        notifyListeners();
      } catch (e) {
        print('Erro ao ler patotas: $e');
        throw Exception('Erro ao ler patotas: $e');
      }
    }
  }

  Future<void> savePatotaInfos(String patota, String organizador) async {
    try {
      if (auth.usuario == null) {
        throw Exception('Usuário não autenticado');
      }

      final patotasIguais =
          await db
              .collectionGroup('patota')
              .where('patota', isEqualTo: patota)
              .get();

      if (patotasIguais.docs.isNotEmpty) {
        throw Exception('Esta patota já está cadastrada!');
      }

      await db
          .collection('patotasUsuario/${auth.usuario!.uid}/patota')
          .doc(patota)
          .set({
            'patota': patota,
            'organizador': organizador,
            'dataCriacao': FieldValue.serverTimestamp(),
          });

      readPatotas();
    } catch (e) {
      print('error');
      print(e);
      throw Exception('Erro ao salvar patota: $e');
    }
  }
}
