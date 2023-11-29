import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialFormEntry extends StatefulWidget {
  final String name;
  final int typeData; // 0 -> int, 1 -> string, 2 -> fecha, 4 -> especial
  final TextEditingController controller;
  final void Function()? onTap;

  const MaterialFormEntry({
    super.key,
    required this.name,
    required this.typeData,
    required this.controller,
    this.onTap,
  });

  @override
  _MaterialFormEntryState createState() => _MaterialFormEntryState();
}

class _MaterialFormEntryState extends State<MaterialFormEntry> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      widget.controller.text = picked.toLocal().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.typeData != 2) // No es 2
            GestureDetector(
              onTap: () {
                widget.onTap?.call(); // Llama a onTap si no es nulo
              },
              child: AbsorbPointer(
                absorbing:
                    widget.typeData == 4, // Absorbe clics si typeData es 4
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    labelText: widget.name,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: _getKeyboardType(),
                  inputFormatters: _getInputFormatters(),
                ),
              ),
            ),
          if (widget.typeData == 2) // Selector de fecha si typeData es 2
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: widget.name,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
        ],
      ),
    );
  }

  TextInputType _getKeyboardType() {
    return widget.typeData == 0 ? TextInputType.number : TextInputType.text;
  }

  List<TextInputFormatter> _getInputFormatters() {
    if (widget.typeData == 0) {
      return [FilteringTextInputFormatter.digitsOnly];
    } else {
      return [];
    }
  }
}
