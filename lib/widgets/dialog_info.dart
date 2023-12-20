import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String message;
  final Function() onPressed;

  const InfoDialog({
    super.key,
    required this.message,
    required this.onPressed
  });
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Información'),
      content: Text(message),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ActionButton(
            text: 'Volver',
            type: 0,
            onPressed: onPressed,
          )
        ),
      ],
    );
  }
}