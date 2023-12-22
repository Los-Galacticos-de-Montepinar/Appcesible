// STUDENT DIARY - Mobile Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:appcesible/screens/task_student_init.dart';
import 'package:appcesible/widgets/widget_top_student.dart';
import 'package:flutter/material.dart';

class StudentDiaryTablet extends StatelessWidget {
  const StudentDiaryTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const TopMenuStudent(texto: 'AGENDA'),
        body: Center(
          child: FittedBox(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_sharp,
                        size: 50, // Ajusta el tamaño según tus necesidades
                        color: Color.fromARGB(
                            255, 0, 0, 0),
                        semanticLabel: 'Siguiente tarea', // Cambia el color de la flecha
                      ),
                    ),
                    const SizedBox(width: 20),
                    const MyBoxWithImageAndText(
                      text: 'PONER LA LAVADORA',
                      image: 'assets/images/lavadora.png',
                      destinationScreen: TaskStudentInit(),
                    ),
                    const SizedBox(width: 40),
                    const MyBoxWithImageAndText(
                      text: 'PONER LA LAVADORA 2',
                      image: 'assets/images/lavadora.png',
                      destinationScreen: TaskStudentInit(),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 50, // Ajusta el tamaño según tus necesidades
                        color: Color.fromARGB(
                            255, 0, 0, 0),
                        semanticLabel: 'Siguiente tarea', // Cambia el color de la flecha
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBoxWithImageAndText extends StatelessWidget {
  final String text;
  final String image;
  final Widget destinationScreen;

  const MyBoxWithImageAndText(
      {super.key,
      required this.text,
      required this.image,
      required this.destinationScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        height: 600,
        width: 350,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.grey[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Text(
              'TAREA',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Container(
              child: imageWidget(image: image),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 120,
              child: SingleChildScrollView(
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 35.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
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
