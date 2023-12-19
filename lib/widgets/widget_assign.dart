import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:appcesible/models/assigments_user.dart';
import 'package:appcesible/widgets/button.dart';

class ShowAssignmentsWidget extends StatelessWidget {
  final AssignmentsUser assignmentUser;
  final Function() newAssignment;
  final int numAssignments;

  const ShowAssignmentsWidget({
    super.key,
    required this.assignmentUser,
    required this.newAssignment,
    required this.numAssignments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.01,
        right: MediaQuery.of(context).size.width * 0.01,
        top: MediaQuery.of(context).size.width * 0.01,
      ),
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            assignmentUser.userName,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Center(
              child: InkWell(
            onTap: () {
              _showTimePopup(context, assignmentUser);
            },
            child: Material(
              elevation:
                  4, // ajusta el valor según sea necesario para la sombra
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.19,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // Fondo gris
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.alarm,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width * 0.07,
                          semanticLabel: 'Icono de Reloj',
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                numAssignments.toString(),
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _showTimePopup(BuildContext context, AssignmentsUser assignmentUser) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Horas',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10), // Espaciado opcional
              Column(
                children: assignmentUser.dates.map((date) {
                  String formattedDateTime =
                      DateFormat('dd MMM yyyy - HH:mm').format(date);
                  return Text(
                    formattedDateTime,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                    text: 'Cerrar',
                    type: 0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                const SizedBox(
                  width: 8.0,
                ),
                ActionButton(
                    text: 'Añadir',
                    type: 1,
                    onPressed: () {
                      newAssignment();
                    }),
              ],
            ),
          ],
        );
      },
    );
  }
}