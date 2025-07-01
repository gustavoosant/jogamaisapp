import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jogamais/databases/db_firestore.dart';
import 'package:jogamais/services/auth_service.dart';

class PatotaRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;

  PatotaRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
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
    } catch (e) {
      print('error');
      print(e);
      throw Exception('Erro ao salvar patota: $e');
    }
  }
}
