import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class TaskInformationTablet extends StatefulWidget {
  const TaskInformationTablet({Key? key}) : super(key: key);

  @override
  _TaskInformationTabletState createState() => _TaskInformationTabletState();
}

class _TaskInformationTabletState extends State<TaskInformationTablet> {
  final TextScaler titlesSize = const TextScaler.linear(3);
  final TextScaler textSize = const TextScaler.linear(2);
  final EdgeInsetsGeometry myPad = const EdgeInsets.all(12);

  Container textContainer(String text, TextScaler fontSize) {
    return Container(
      padding: myPad,
      alignment: Alignment.topLeft,
      child: Text(text, textAlign: TextAlign.left, textScaler: fontSize),
    );
  }

  Container bigContainer(BuildContext context, Size screenSize, bool delayed,
      String state, String date, String hour, String delay) {
    return Container(
      margin: myPad,
      width: screenSize.width * 0.5,
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          textContainer("Detalles", titlesSize),
          textContainer("Estado - $state", textSize),
          if (!delayed) textContainer("Fecha de Realizacion $date", textSize),
          if (!delayed) textContainer("Hora de realizacion $hour", textSize),
          if (delayed) textContainer("Retraso $delay", textSize),
        ],
      ),
    );
  }

  Container littleContainer(
      BuildContext context, Size screenSize, String title, String text) {
    return Container(
      height: screenSize.height * 0.3,
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          textContainer(title, titlesSize),
          textContainer(text, textSize),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool delayed = false;

    return Scaffold(
      appBar: const TopMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: myPad,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.maxFinite,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(
                  child: Text(
                    'Información de la tarea',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: myPad,
                child: SizedBox(
                  height: screenSize.height * 0.6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            littleContainer(
                              context,
                              screenSize,
                              "Tarea",
                              "Nombre Tarea",
                            ),
                            littleContainer(
                              context,
                              screenSize,
                              "Estudiante",
                              "Nombre estudiante",
                            ),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(color: Colors.black),
                          width: screenSize.width * 0.001,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: bigContainer(
                            context,
                            screenSize,
                            delayed,
                            "Completada",
                            "Fecha",
                            "Hora",
                            "3 dias",
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
                  type: 0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
