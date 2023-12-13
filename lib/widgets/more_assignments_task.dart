import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pair/pair.dart';

import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/widgets/dialog_button.dart';

Future<bool?> showConfirmationDialog(BuildContext context, Pair<UserModel, DateTime> selectedAssignment) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          selectedAssignment.key.userName,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // lIST VIEW DE TODAS LAS ASIGNACIONES A UN ESTUDIANTE CON NOMBRE selectedAssignment.key
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Grey
                borderRadius: BorderRadius.circular(8), // Border on circle
                border: Border.all(color: Colors.black), // Black border
              ),
              child: Center(
                child: Text(
                  DateFormat.yMd().add_jm().format(selectedAssignment.value),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: Text(
                  '¿Desea confirmar la asignación?',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center, // Alinea el texto al centro
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DialogButton(
                text: 'No',
                type: 0,
                onPressed: () {
                  Navigator.pop(context, false);
                }
              ),
              const SizedBox(width: 8.0,),
              DialogButton(
                text: 'Sí',
                type: 1,
                onPressed: () {
                  Navigator.pop(context, true);
                }
              ),
            ],
          ),
        ],
      );
    },
  );
}
