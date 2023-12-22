import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class StudentInformationTablet extends StatelessWidget {
  const StudentInformationTablet({Key? key});

  final double titlesSize = 35.0;
  final double textSize = 20.0;
  final EdgeInsetsGeometry myPad = const EdgeInsets.all(12);

  Container textContainer(String text, double fontSize) {
    return Container(
      padding: myPad,
      alignment: Alignment.topLeft,
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
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
                  width: double.maxFinite,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      "Información Estudiante",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                                      "Modo de visualizacion",
                                      "Modo",
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
                  child: ActionButton(
                    text: "Volver",
                    type: 1,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
