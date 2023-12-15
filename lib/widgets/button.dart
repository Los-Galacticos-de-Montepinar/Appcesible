import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final int type;       // 0 - Relleno | 1 - Sin relleno
  final Function() onPressed;

  const ActionButton({super.key, required this.text, required this.type, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: (type == 0) ? const Color(0xFFBF1717).withOpacity(0.8) : const Color(0xFF333333).withOpacity(0.8),
        backgroundColor: (type == 0) ? const Color(0xFFBF1717).withOpacity(0.8) : const Color(0xFF333333).withOpacity(0.8), // Color de fondo
        minimumSize: const Size(120, 40)
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // Color del texto blanco
        ),
      ),
    );
  }
}