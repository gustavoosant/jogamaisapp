import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jogamais/databases/db_firestore.dart';
import 'package:jogamais/services/auth_service.dart';

class EventoRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;
  final List<String> _listaPatotas = [];
  final List<Map<String, dynamic>> _listaEventos = [];
  List<Map<String, dynamic>> get eventos => _listaEventos;

  List<String> get patotas => _listaPatotas;

  EventoRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future<void> saveEventoInfos(
    String patotaSelecionada,
    String horarioEvento,
    String dataEvento,
    String descEvento,
    String ruaEvento,
    String numeroEvento,
    String cepEvento,
  ) async {
    try {
      if (auth.usuario == null) {
        throw Exception('Usuário não autenticado');
      }

      await db.collection('eventosPatota/${auth.usuario!.uid}/eventos').add({
        'patota': patotaSelecionada,
        'descEvento': descEvento,
        'horarioEvento': horarioEvento,
        'dataEvento': dataEvento,
        'ruaEvento': ruaEvento,
        'numeroEvento': numeroEvento,
        'cepEvento': cepEvento,
        'dataCriacao': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('error');
      print(e);
      throw Exception('Erro ao salvar patota: $e');
    }
  }

  Future<void> readEventos() async {
    if (auth.usuario != null) {
      try {
        final eventosUsuario =
            await db
                .collection('eventosPatota/${auth.usuario!.uid}/eventos')
                .orderBy('dataCriacao', descending: false)
                .limit(5)
                .get();

        _listaEventos.clear();
        for (var doc in eventosUsuario.docs) {
          final eventoData = doc.data();
          eventoData['id'] = doc.id;
          _listaEventos.add(eventoData);
        }
        notifyListeners();
      } catch (e) {
        print('Erro ao ler eventos: $e');
        throw Exception('Erro ao ler eventos: $e');
      }
    }
  }

  Future<String> getOrganizadorPatota(String nomePatota) async {
    try {
      final patotaDoc =
          await db
              .collection('patotasUsuario/${auth.usuario!.uid}/patota')
              .doc(nomePatota)
              .get();

      if (patotaDoc.exists) {
        return patotaDoc.data()?['organizador'] ?? 'N/A';
      }
      notifyListeners();
      return 'N/A';
    } catch (e) {
      return 'N/A';
    }
  }
}
