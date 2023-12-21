import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class TaskInformationMobile extends StatelessWidget {
  const TaskInformationMobile({super.key});

  final TextScaler titlesSize = const TextScaler.linear(1.5);
  final TextScaler textSize = const TextScaler.linear(1);
  final EdgeInsetsGeometry myPad = const EdgeInsets.all(4);

  /**
   * Container en el que guardo un texto para que se pegue a la izquierda del column
   */
  Padding textContainer(String text, TextScaler fontSize) {
    return Padding(
        padding: myPad,
        child: Container(
          alignment: Alignment.topLeft,
          child: Text(text, textAlign: TextAlign.left, textScaler: fontSize),
        ));
  }

  /**
   * Container de los detalles de la tarea
   */
  Container bigContainer(BuildContext context, Size screenSize, bool delayed,
      String state, String date, String hour, String delay) {
    return Container(
      margin: myPad,
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          textContainer("Detalles", titlesSize),
          textContainer("Estado - " + state, textSize),
          !delayed
              ? textContainer("Fecha de Realizacion " + date, textSize)
              : Container(),
          !delayed
              ? textContainer("Hora de realizacion " + hour, textSize)
              : Container(),
          delayed ? textContainer("Retraso " + delay, textSize) : Container()
        ],
      ),
    );
  }

  /**
   * Container del nombre de la tarea y del nombre del alumno 
   */
  Container litlleContainer(
      BuildContext context, Size screenSize, String title, String text) {
    return Container(
      height: screenSize.height * 0.12,
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          textContainer(title, titlesSize),
          textContainer(text, textSize)
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  /**
                 * Título gris de la ventana
                 */
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        border: Border.all(color: Colors.black)),
                    child: Text("Información Tarea", textScaler: titlesSize),
                  ),
                  /**
                 * Nombre de la tarea
                 */
                  litlleContainer(context, screenSize, "Tarea", "Nombre tarea"),
                  /**
                 * Nombre del alumno
                 */
                  litlleContainer(
                      context, screenSize, "Estudiante", "Nombre alumno"),
                  /**
                 * Información de la tarea
                 */
                  bigContainer(context, screenSize, delayed, "Completada",
                      "Fecha", "Hora", "X dias"),
                  /**
                 * Boton de volver
                 */
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
                            minimumSize: Size(screenSize.width * 0.5,
                                screenSize.height * 0.08),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0))),
                        child: Text("Volver", textScaler: titlesSize),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
