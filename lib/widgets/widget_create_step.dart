import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';

class NewStep extends StatelessWidget {
  const NewStep({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController step = TextEditingController();

    return Scaffold(
      appBar: TopMenu(
        onHomeTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return ConfirmationDialog(
                message: '¿Está seguro de que quiere abandonar el proceso?\nLos datos introducidos hasta el momento se perderán',
                onConfirm: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) {
                        return const TeacherHome();
                      }
                    ),
                    (route) => false
                  );
                }
              );
            }
          );
        }
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(10, 10),
                  ),
                ],
              ),
              child: const Text(
                'Añadir nuevo paso',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 70,
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Texto asociado',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: step,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Descripción del paso',
                    hintText: 'Descripción del paso',
                    //errorText: 'contraseña incorrecta',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 255),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
