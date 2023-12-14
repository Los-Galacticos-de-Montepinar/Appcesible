import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.message,
    required this.onConfirm
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmación'),
      content: Text(message),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButton(
              text: 'Cancelar',
              type: 1,
              onPressed: () {
                Navigator.pop(context); // Cerrar la ventana emergente de confirmación
              }
            ),
            ActionButton(
              text: 'Confirmar',
              type: 0,
              onPressed: () {
                Navigator.pop(context); // Cerrar la ventana emergente de confirmación
                onConfirm(); // Llamar a la función de confirmación
              }
            ),
          ],
        ),
      ],
    );
  }
}