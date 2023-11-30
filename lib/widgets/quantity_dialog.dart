import 'package:flutter/material.dart';

class QuantityDialog extends StatefulWidget {
  final String material;
  final ValueChanged<int> onQuantitySelected;

  const QuantityDialog({
    super.key,
    required this.material,
    required this.onQuantitySelected,
  });

  @override
  State<QuantityDialog> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar Cantidad'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra los botones horizontalmente
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (quantity > 1) {
                      quantity--;
                    }
                  });
                },
              ),
              Text('$quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ), // Añade espacio entre los botones y el texto
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra los botones horizontalmente
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color de fondo rojo
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
                widget.onQuantitySelected(quantity);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Color de fondo verde
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Bordes redondos
                ),
              ),
              child: const Text(
                'Aceptar',
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
