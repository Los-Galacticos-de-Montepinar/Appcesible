import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';

class StudentInformationTablet extends StatelessWidget {
  const StudentInformationTablet({Key? key});

  final TextScaler titlesSize = const TextScaler.linear(3);
  final TextScaler textSize = const TextScaler.linear(2);
  final EdgeInsetsGeometry myPad = const EdgeInsets.all(12);

  Padding textContainer(String text, TextScaler fontSize) {
    return Padding(
      padding: myPad,
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(text, textAlign: TextAlign.left, textScaler: fontSize),
      ),
    );
  }

  Container informationContainer(
      BuildContext context, Size screenSize, String title, String text) {
    return Container(
      height: screenSize.height * 0.3,
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          textContainer(title, titlesSize),
          textContainer(text, textSize),
        ],
      ),
    );
  }

  Container detailsContainer(BuildContext context, Size screenSize,
      bool delayed, String state, String date, String hour, String delay) {
    return Container(
      margin: myPad,
      width: screenSize.width * 0.5,
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          Padding(
            padding: myPad,
            child: informationContainer(
              context,
              screenSize,
              "Matrícula",
              "Número de matrícula",
            ),
          ),
          Padding(
            padding: myPad,
            child: informationContainer(
              context,
              screenSize,
              "Carrera",
              "Carrera del estudiante",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    bool delayed = false;

    return MaterialApp(
      home: Scaffold(
        appBar: const TopMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: myPad,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Text("Información Estudiante",
                      textScaler: TextScaler.linear(3)),
                ),
                Padding(
                  padding: myPad,
                  child: SizedBox(
                    height: screenSize.height * 0.7,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.4,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: myPad,
                                    child: informationContainer(
                                      context,
                                      screenSize,
                                      "Nombre",
                                      "Nombre del estudiante",
                                    ),
                                  ),
                                  Padding(
                                    padding: myPad,
                                    child: informationContainer(
                                      context,
                                      screenSize,
                                      "Correo",
                                      "Correo electrónico del estudiante",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            width: screenSize.width * 0.001,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: detailsContainer(
                              context,
                              screenSize,
                              delayed,
                              "Completada",
                              "",
                              "",
                              "3 días",
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: myPad,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      minimumSize:
                          Size(screenSize.width * 0.6, screenSize.height * 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text("Volver", textScaler: titlesSize),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
