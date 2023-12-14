import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';

class ErrorWindow {
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ActionButton(text: 'Volver', type: 0, onPressed: () {
                Navigator.of(context).pop();
              })
            ),
          ],
        );
      },
    );
  }
}