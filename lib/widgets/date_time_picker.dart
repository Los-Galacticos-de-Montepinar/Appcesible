import 'package:appcesible/widgets/dialog_error.dart';
import 'package:flutter/material.dart';

class DateTimePicker {
  static Future<DateTime?> selectDate(BuildContext context) async {
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

    if (picked != null) {
      DateTime now = DateTime.now();
      if (picked.compareTo(DateTime(now.year, now.month, now.day)) >= 0) {
        return picked;
      }
      else {
        ErrorWindow.showErrorDialog(
          context,
          'La fecha debe ser, al menos, igual al día de hoy'
        );
        print('Fecha inválida');
      }
    }

    return null;
  }

  static Future<TimeOfDay?> selectTime(BuildContext context) async {
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
}