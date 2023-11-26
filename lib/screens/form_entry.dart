import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialFormEntry extends StatelessWidget {
  final String name;
  final int typeData; // 0 -> int, 1 -> string

  const MaterialFormEntry({
    Key? key,
    required this.name,
    required this.typeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: name,
              border: const OutlineInputBorder(),
            ),
            keyboardType:
                TextInputType.number, // Establecer el tipo de teclado a número
            inputFormatters: _getInputFormatters(), // Añadir input formatters
          ),
        ],
      ),
    );
  }

  List<TextInputFormatter> _getInputFormatters() {
    if (typeData == 0) {
      // Si el tipo de dato es 0 (int), añadir input formatter para aceptar solo números
      return [FilteringTextInputFormatter.digitsOnly];
    } else {
      // Si el tipo de dato es 1 (string), no añadir input formatter
      return [];
    }
  }
}
