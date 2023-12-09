import 'package:flutter/material.dart';

Future<void> dialogBuilder(BuildContext context, String text) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
          return AlertDialog(
          title: const Text("Alerta"),
          content: Text(text),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("CERRAR", style: TextStyle(color: Colors.black),),
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );
      }
    );
  }