// STUDENT DIARY - Mobile Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:appcesible/screens/congratulations_init.dart';
import 'package:appcesible/screens/stepTaskView.dart';
import 'package:appcesible/screens/step_check.dart';
import 'package:appcesible/widgets/widget_top_student.dart';
import 'package:flutter/material.dart';

class StudentTask extends StatelessWidget {
  const StudentTask({super.key});

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
                        imageWidget(image: 'assets/images/lavadora.png'),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Poner la lavadora',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.09,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // const stepTaskView(
                    //     text: 'HOLA',
                    //     image: 'HOLA',
                    //     destinationScreen: StepCompletionCheckScreen(
                    //       image: "assets/images/pasoCompletado.png",
                    //       texto: "¿Paso Completado?",
                    //     )),
                    const SizedBox(height: 20),
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
                        Icons.keyboard_double_arrow_down_outlined,
                        size: 60, // Ajusta el tamaño según tus necesidades
                        color: Color.fromARGB(
                            255, 0, 0, 0),
                        semanticLabel: "Siguiente paso", // Cambia el color de la flecha
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )));
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 260,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.contain)),
    );
  }
}
