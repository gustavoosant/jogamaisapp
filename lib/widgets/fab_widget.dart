import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:jogamais/screens/nova_patota_screen.dart';
import 'package:jogamais/screens/novo_evento_screen.dart';

class CustomFab extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add_circle_outline,
      activeIcon: Icons.close_outlined,
      backgroundColor: const Color(0xFF151B34),
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.red,
      activeForegroundColor: Colors.white,
      buttonSize: Size(60.0, 60.0),
      overlayColor: Colors.black,
      overlayOpacity: 0.3,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color(0xFFB0B1C6),
          foregroundColor: Colors.white,
          label: 'Criar novo Evento',
          labelStyle: TextStyle(
            color: Color(0xFF151B34),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          labelBackgroundColor: const Color(0xFFB0B1C6),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NovoEventoScreen(),
                ),
              ),
        ),
        SpeedDialChild(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color(0xFFB0B1C6),
          foregroundColor: Colors.white,
          label: 'Criar nova Patota',
          labelStyle: TextStyle(
            color: Color(0xFF151B34),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          labelBackgroundColor: const Color(0xFFB0B1C6),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NovaPatotaScreen(),
                ),
              ),
        ),
      ],
    );
  }
}
