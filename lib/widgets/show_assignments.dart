import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:appcesible/models/assigments_user.dart';
import 'package:appcesible/widgets/dialog_button.dart';

class ShowAssignmentsWidget extends StatelessWidget {
  final AssignmentsUser assignmentUser;

  const ShowAssignmentsWidget(this.assignmentUser, {super.key});

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
              child: Ink(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.access_time, color: Colors.black),
                ),
              ),
            ),
          ),
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
            Container(
              alignment: Alignment.center,
              child: DialogButton(
                text: 'Cerrar',
                type: 0, // Rojo
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
