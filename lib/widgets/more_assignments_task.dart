import 'package:appcesible/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pair/pair.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context, Pair<UserModel, DateTime> selectedAssignment) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name student
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.01,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: Text(
                  selectedAssignment.key.userName,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

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

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.red, // Color de fondo del primer botón
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Cerrar el diálogo y confirmar la asignación
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        'Sí',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre los contenedores
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      color:
                          Colors.grey[900], // Color de fondo del segundo botón
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Cerrar el diálogo sin realizar ninguna acción
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
