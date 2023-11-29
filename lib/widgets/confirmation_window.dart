import 'package:flutter/material.dart';

class ConfirmationWindow extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmationWindow({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmación'),
      content: const Text('Se va a crear una tarea pedido. ¿Continuar?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context); // Cerrar la ventana emergente de confirmación
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Color de fondo rojo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Bordes redondos
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white, // Color del texto blanco
                ),
              ),
            ),
            const SizedBox(width: 10.0), // Añade espacio entre los botones
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context); // Cerrar la ventana emergente de confirmación
                onConfirm(); // Llamar a la función de confirmación
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Color de fondo verde
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Bordes redondos
                ),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(
                  color: Colors.white, // Color del texto blanco
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
