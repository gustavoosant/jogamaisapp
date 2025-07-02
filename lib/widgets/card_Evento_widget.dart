import 'package:flutter/material.dart';

Widget buildEventoCard({
  required String nomePatota,
  required String organizador,
  required String descEvento,
  required String dataEvento,
  required String horarioEvento,
  required String localEvento,
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
              Text(
                nomePatota,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF151B34),
                ),
              ),
            ],
          ),
          const SizedBox(height: 1),
          Row(
            children: [
              Text(
                'Organizador: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text('$organizador'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            descEvento,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF151B34),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Dia: ', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('$dataEvento'),
                  const SizedBox(width: 8),
                  Text(
                    'Horário: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text('$horarioEvento'),
                ],
              ),

              Row(
                children: [
                  Text(
                    'Local: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text('$localEvento'),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
