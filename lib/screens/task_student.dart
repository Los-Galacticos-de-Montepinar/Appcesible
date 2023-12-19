// STUDENT DIARY - Mobile Version
// Autor: Alejandro Sanchez Rodríguez

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
                    const StepBox(
                        text: 'HOLA',
                        image: 'HOLA',
                        destinationScreen: StudentTask()),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                      },
                      child: const Icon(
                        Icons.keyboard_double_arrow_down_outlined,
                        size: 50, // Ajusta el tamaño según tus necesidades
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Cambia el color de la flecha
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

// Class designed to create a box containing both text and an image
class StepBox extends StatelessWidget {
  final String text;
  final String image;
  final Widget destinationScreen;

  const StepBox(
      {super.key,
      required this.text,
      required this.image,
      required this.destinationScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla de destino cuando se toca la caja
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        width: MediaQuery.of(context).size.width * 1.1,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.grey[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PASO 1',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                imageWidget(image: 'assets/images/lavadora.png', context: context),
                const SizedBox(width: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width * 0.39,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Poner la ropa en la lavadora',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.082,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
               
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget({required String image, required BuildContext context }) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.contain)),
    );
  }
}
