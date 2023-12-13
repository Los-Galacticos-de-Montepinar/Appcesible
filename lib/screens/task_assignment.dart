import 'package:appcesible/widgets/my_button.dart';
import 'package:appcesible/widgets/seleccionar_estudiante_window.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class TaskAssignment extends StatefulWidget {
  const TaskAssignment({Key? key}) : super(key: key);

  @override
  _TaskAssignmentState createState() => _TaskAssignmentState();
}

class _TaskAssignmentState extends State<TaskAssignment> {
  // Variables para la tarea
  String taskImageUrl = 'assets/images/lavadora.png';
  String taskTitle = 'Poner Lavadora';

  String studentName = " ";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const TopMenu(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Row with image and task
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Task image
                      Image.asset(
                        taskImageUrl,
                        width: MediaQuery.of(context).size.width * 0.26,
                        height: MediaQuery.of(context).size.width * 0.26,
                      ),

                      const SizedBox(width: 20),

                      // Text task
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            taskTitle,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // "Sin asignar alumnos"
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Grey
                    borderRadius: BorderRadius.circular(8), // Border on circle
                    border: Border.all(color: Colors.black), // Black border
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Sin asignar alumnos',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width *
                              0.06, // Ajusta según sea necesario
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // GestureDetector con imagen
                GestureDetector(
                  onTap: () {
                    _showEstudiantePopup();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.17,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.black), // Black border
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/taskAssignment.png', // Image url button
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.17,
                        // Ajusta el ancho y alto según sea necesario
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                // Button "Confirmar"
                MyButton(
                  buttonText: 'Confirmar',
                  colorBackground: Colors.grey[800], // Gris oscuro
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // On tap function for "selection student" field
  void _showEstudiantePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SeleccionarEstudianteWindow();
      },
    );

    if (result != null) {
      setState(() {
        studentName = result;
      });

      final result1 = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SeleccionarEstudianteWindow();
        },
      );
    }

    print(studentName);
  }
}
