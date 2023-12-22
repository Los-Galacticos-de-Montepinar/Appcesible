import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/rendering.dart';

class TaskInformationMobile extends StatelessWidget {
  const TaskInformationMobile({Key? key}) : super(key: key);

  final double titlesSize = 20.0;
  final double textSize = 14.0;
  final EdgeInsetsGeometry myPad = const EdgeInsets.all(8);

  Padding textContainer(String text, double fontSize) {
    return Padding(
      padding: myPad,
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(text,
            textAlign: TextAlign.left, style: TextStyle(fontSize: fontSize)),
      ),
    );
  }

  Container bigContainer(BuildContext context, bool delayed, String state,
      String date, String hour, String delay) {
    return Container(
      margin: myPad,
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

  Container littleContainer(BuildContext context, String title, String text) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(bottom: 8), // Añadido para evitar el overflow
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textContainer(title, titlesSize),
          textContainer(text, textSize),
        ],
      ),
    );
  }

  Container normalContainer(String title, String text) {
    return Container(
      padding: myPad,
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textContainer(title, titlesSize),
          textContainer(text, textSize),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool delayed = false;

    return MaterialApp(
      home: Scaffold(
        appBar: const TopMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                  child: const Center(
                    child: Text(
                      'Información Tarea',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                normalContainer("Tarea", "Nombre tarea"),
                normalContainer("Estudiante", "Nombre alumno"),
                bigContainer(
                  context,
                  delayed,
                  "Completada",
                  "Fecha",
                  "Hora",
                  "X dias",
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: myPad,
                  child: ActionButton(text: "Volver", type: 1, onPressed: () {
                    Navigator.of(context).pop();
                  },)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
