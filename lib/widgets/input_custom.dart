import 'package:appcesible/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormEntry extends StatefulWidget {
  final String name;
  final int typeData; // 0 -> int, 1 -> string, 2 -> fecha, 4 -> especial
  final TextEditingController controller;
  final void Function()? onTap;

  const FormEntry({
    super.key,
    required this.name,
    required this.typeData,
    required this.controller,
    this.onTap,
  });

  @override
  State<FormEntry> createState() => _FormEntryState();
}

class _FormEntryState extends State<FormEntry> {
  Future _selectDateTime(BuildContext context) async {
    DateTime? date = await DateTimePicker.selectDate(context);
    if (date == null) {
      return;
    }

    TimeOfDay? time = await DateTimePicker.selectTime(context);
    if (time == null) {
      return;
    }

    String dateStr = DateFormat.yMEd('es_ES').format(date);
    dateStr = '${dateStr[0].toUpperCase()}${dateStr.substring(1)}';
    String timeStr = time.format(context);

    widget.controller.text = '$dateStr $timeStr';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.typeData != 2) // No es 2
          GestureDetector(
            onTap: () {
              widget.onTap?.call(); // Llama a onTap si no es nulo
            },
            child: AbsorbPointer(
              absorbing: widget.typeData == 4, // Absorbe clics si typeData es 4
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  labelText: widget.name,
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: _getKeyboardType(),
                inputFormatters: _getInputFormatters(),
              ),
            ),
          ),
        if (widget.typeData == 2) // Selector de fecha si typeData es 2
          TextFormField(
            controller: widget.controller,
            readOnly: true,
            onTap: () {
              _selectDateTime(context);
            },
            // enabled: false,
            decoration: InputDecoration(
              labelText: widget.name,
              labelStyle: const TextStyle(color: Colors.black),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
      ],
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
