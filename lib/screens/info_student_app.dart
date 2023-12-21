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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      border: Border.all(color: Colors.black)),
                  child: Text("Información Estudiante", textScaler: titlesSize),
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
                  "Matrícula",
                  "Número de matrícula",
                ),
                informationContainer(
                  context,
                  screenSize,
                  "Carrera",
                  "Carrera del estudiante",
                ),
                informationContainer(
                  context,
                  screenSize,
                  "Correo Electrónico",
                  "correo@ejemplo.com",
                ),
                Padding(
                  padding: myPad,
                  child: Container(
                    height: screenSize.height * 0.25,
                    alignment: Alignment.bottomCenter,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red[900],
                        minimumSize: Size(
                          screenSize.width * 0.5,
                          screenSize.height * 0.08,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text("Volver", textScaler: titlesSize),
                    ),
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
