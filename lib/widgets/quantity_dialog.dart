import 'package:flutter/material.dart';

import 'package:appcesible/widgets/dialog_button.dart';

class QuantityDialog extends StatefulWidget {
  final String element;
  final int? maxValue;
  final ValueChanged<int> onQuantitySelected;

  const QuantityDialog({
    super.key,
    required this.element,
    this.maxValue,
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
                onPressed: (quantity <= 1)
                ? null
                : () {
                  setState(() {
                    quantity--;
                  });
                },
              ),
              Text(
                '$quantity',
                textScaler: const TextScaler.linear(2.0),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: (quantity >= (widget.maxValue ?? double.infinity))
                ? null
                : () {
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
