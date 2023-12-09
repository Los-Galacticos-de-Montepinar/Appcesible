import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final int type;       // 0 - Relleno | 1 - Sin relleno
  final Function() onPressed;

  const DialogButton({super.key, required this.text, required this.type, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: (type == 0) ? const Color(0xFFBF1717) : Colors.white,
        backgroundColor: (type == 0) ? const Color(0xFFBF1717) : Colors.white, // Color de fondo
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0), // Bordes redondos
          side: const BorderSide(
            color: Color(0xFFBF1717),
            width: 2.0
          )
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: (type == 0) ? Colors.white : const Color(0xFFBF1717), // Color del texto blanco
        ),
      ),
    );
  }
}