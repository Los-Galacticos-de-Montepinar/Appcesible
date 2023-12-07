import 'package:flutter/material.dart';

import 'package:appcesible/models/task_model.dart';
import 'package:appcesible/widgets/dialog_button.dart';

class QuantityDialog extends StatefulWidget {
  final TaskItem material;
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
            mainAxisAlignment: MainAxisAlignment.center, // Centra los botones horizontalmente
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
              Text(
                '$quantity',
                textScaler: const TextScaler.linear(2.0),
              ),
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
        ],
      ),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Centra los botones horizontalmente
          children: [
            DialogButton(text: 'Cancelar', type: 1, onPressed: () {
              Navigator.of(context).pop();
            },),
            DialogButton(text: 'Aceptar', type: 0, onPressed: () {
              widget.onQuantitySelected(quantity);
              Navigator.of(context).pop();
            }),
          ],
        ),
      ],
    );
  }
}
