import 'package:flutter/material.dart';

Widget buildEventoCard({
  required String nomePatota,
  required String organizador,
  required String descricao,
  required String data,
  required String horario,
  required String local,
  required int confirmados,
}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: const Color(0xFFB0B1C6),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nomePatota,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF151B34))),
              Text('$confirmados Confirmados'),
            ],
          ),
          const SizedBox(height: 1),
          Text('Organizador: $organizador'),
          Text(descricao, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dia: $data'),
              Text('Horário: $horario'),
              Text('Local: $local'),
            ],
          ),
        ],
      ),
    ),
  );
}