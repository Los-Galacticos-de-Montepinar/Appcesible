import 'package:appcesible/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  State<MaterialFormEntry> createState() => _MaterialFormEntryState();
}

class _MaterialFormEntryState extends State<MaterialFormEntry> {
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? date = await _selectDate(context);
    if (date == null) return;

    TimeOfDay? time = await _selectTime(context);
    if (time == null) return;

    String dateStr = DateFormat.yMEd('es_ES').format(date);
    dateStr = '${dateStr[0].toUpperCase()}${dateStr.substring(1)}';
    String timeStr = time.format(context);

    widget.controller.text = '$dateStr $timeStr';
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF9E9E9E),
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black
              )
            )
          ),
          child: child!
        );
      },
    );

    if (picked!.compareTo(DateTime.now()) >= 0) {
      return picked;
    }
    else {
      ErrorWindow.showErrorDialog(
        context,
        'La fecha debe ser, al menos, igual al día de hoy'
      );
      print('Fecha inválida');
    }

    return null;
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF9E9E9E),
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black
              )
            )
          ),
          child: child!
        );
      },
    );

    return picked;
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
                    style: const TextStyle(

                    ),
                    decoration: InputDecoration(
                      labelText: widget.name,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDateTime(context);
                  },
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
