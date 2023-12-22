import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class StudentInformationMobile extends StatelessWidget {
  const StudentInformationMobile({Key? key});

  final TextScaler titlesSize = const TextScaler.linear(1.5);
  final TextScaler textSize = const TextScaler.linear(1);
  final EdgeInsetsGeometry myPad = const EdgeInsets.all(4);

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
      height: screenSize.height * 0.12,
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          textContainer(title, titlesSize),
          textContainer(text, textSize),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: const TopMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
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
                informationContainer(
                  context,
                  screenSize,
                  "Estudiante",
                  "Nombre del estudiante",
                ),
                informationContainer(
                  context,
                  screenSize,
                  "Modo de visualizacion",
                  "Modo",
                ),
                informationContainer(
                  context,
                  screenSize,
                  "Clase",
                  "Clase del alumno",
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
