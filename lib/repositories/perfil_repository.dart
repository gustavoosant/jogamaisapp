import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jogamais/databases/db_firestore.dart';
import 'package:jogamais/services/auth_service.dart';

class PerfilRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService auth;
  String? nome;
  String? sobrenome;
  String? usuario;

  PerfilRepository({required this.auth}) {
    _startRepository();
    if (auth.usuario != null) {
      _readPerfil();
    }
    _listenMudancasAuth();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  void _listenMudancasAuth() {
    auth.addListener(() {
      if (auth.usuario != null) {
        _readPerfil();
      } else {
        nome = null;
        sobrenome = null;
        usuario = null;
        notifyListeners();
      }
    });
  }

  _readPerfil() async {
    if (auth.usuario != null) {
      try {
        final perfilDocs =
            await db.collection('usuarios/${auth.usuario!.uid}/perfil').get();

        if (perfilDocs.docs.isNotEmpty) {
          final perfilData = perfilDocs.docs.first.data();
          nome = perfilData['nome'] ?? '';
          sobrenome = perfilData['sobrenome'] ?? '';
          usuario = perfilData['usuario'] ?? '';
        } else {
          nome = '';
          sobrenome = '';
          usuario = '';
        }
        notifyListeners();
      } catch (e) {
        nome = '';
        sobrenome = '';
        usuario = '';
      }
    }
  }

  Future<void> savePerfilInfos(
    String nome,
    String sobrenome,
    String usuario,
  ) async {
    try {
      if (auth.usuario == null) {
        throw Exception('Usuário não autenticado');
      }

      final perfilExistente =
          await db.collection('usuarios/${auth.usuario!.uid}/perfil').get();

      if (perfilExistente.docs.isEmpty) {
        final usuariosIguais =
            await db
                .collectionGroup('perfil')
                .where('usuario', isEqualTo: usuario)
                .get();

        if (usuariosIguais.docs.isNotEmpty) {
          throw Exception('Este nome de usuário já está em uso!');
        }

        await db
            .collection('usuarios/${auth.usuario!.uid}/perfil')
            .doc(usuario)
            .set({
              'nome': nome,
              'sobrenome': sobrenome,
              'usuario': usuario,
              'dataCriacao': FieldValue.serverTimestamp(),
            });
      } else {
        final perfilAtual = perfilExistente.docs.first.data();
        final nomeAtual = perfilAtual['nome'] ?? '';
        final sobrenomeAtual = perfilAtual['sobrenome'] ?? '';
        final usuarioAtual = perfilAtual['usuario'] ?? '';

        if (nome != nomeAtual ||
            sobrenome != sobrenomeAtual ||
            usuario != usuarioAtual) {
          if (usuario != usuarioAtual) {
            final usuariosIguais =
                await db
                    .collectionGroup('perfil')
                    .where('usuario', isEqualTo: usuario)
                    .get();

            if (usuariosIguais.docs.isNotEmpty) {
              throw Exception('Este nome de usuário já está em uso!');
            }
          }

          await db
              .collection('usuarios/${auth.usuario!.uid}/perfil')
              .doc(usuarioAtual)
              .update({
                'nome': nome,
                'sobrenome': sobrenome,
                'usuario': usuario,
                'dataAtualizacao': FieldValue.serverTimestamp(),
              });

          if (usuario != usuarioAtual) {
            await db
                .collection('usuarios/${auth.usuario!.uid}/perfil')
                .doc(usuario)
                .set({
                  'nome': nome,
                  'sobrenome': sobrenome,
                  'usuario': usuario,
                  'dataCriacao': perfilAtual['dataCriacao'],
                  'dataAtualizacao': FieldValue.serverTimestamp(),
                });

            await db
                .collection('usuarios/${auth.usuario!.uid}/perfil')
                .doc(usuarioAtual)
                .delete();
          }
        }
      }
      this.nome = nome;
      this.sobrenome = sobrenome;
      this.usuario = usuario;
      notifyListeners();
    } catch (e) {
      print('error');
      print(e);
      throw Exception('Erro ao salvar perfil: $e');
    }
  }
}
