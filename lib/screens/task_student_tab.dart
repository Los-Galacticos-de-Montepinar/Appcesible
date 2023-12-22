// STUDENT DIARY - Mobile Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:appcesible/screens/congratulations_init.dart';
import 'package:appcesible/screens/stepTaskViewTablet.dart';
import 'package:appcesible/screens/step_check.dart';
import 'package:appcesible/screens/task_student_init.dart';
import 'package:appcesible/widgets/widget_top_student.dart';
import 'package:flutter/material.dart';

class StudentTaskTablet extends StatelessWidget {
  const StudentTaskTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: const TopMenuStudent(texto: 'TAREA'),
            body: Center(
              child: FittedBox(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            imageWidget(image: 'assets/images/lavadora.png'),
                            const SizedBox(height: 0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Poner la lavadora',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(width: 20),
                        const stepTaskViewTablet(
                            text: 'HOLA',
                            image: 'HOLA',
                            destinationScreen: StepCheck(
                              image: "assets/images/pasoCompletado.png",
                              texto: "¿Paso Completado?",
                              destinationScreen: TaskStudentInit(),
                            )),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CongratulationsInit()),
                            );
                          },
                          child: const Icon(
                            Icons.keyboard_double_arrow_right_outlined,
                            size: 50, // Ajusta el tamaño según tus necesidades
                            color: Color.fromARGB(
                                255, 0, 0, 0), // Cambia el color de la flecha
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 360,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.contain)),
    );
  }
}
