import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:pair/pair.dart';

import 'package:appcesible/models/assigments_user.dart';
import 'package:appcesible/models/task_model.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/services/task_service.dart';
import 'package:appcesible/services/user_service.dart';

import 'package:appcesible/widgets/dialog_list_assign.dart';
import 'package:appcesible/widgets/dialog_list_search.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_assign.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class TaskAssignment extends StatefulWidget {
  const TaskAssignment({super.key});

  @override
  State<TaskAssignment> createState() => _TaskAssignmentState();
}

class _TaskAssignmentState extends State<TaskAssignment> {
  // Variables para la tarea
  String taskImageUrl = 'assets/images/lavadora.png'; // Image url task default
  String taskTitle = 'Poner Lavadora';

  UserModel? selectedUser;

  List<UserModel> students = [];
  List<UserModel> teachers = [];
  bool initialized = false;

  List<AssignmentsUser> selectedAssignments = [];

  @override
  void initState() {
    initializeState();
    super.initState();
  }

  Future<void> initializeState() async {
    if (!initialized) {
      List<UserModel> users = await getAllUsers();

      teachers = users.where((user) => user.userType != 1).toList();
      students = users.where((user) => user.userType == 1).toList();

      // NO LO HE HECHO, ERROR EN DATOS DE BD, NULL EN ID_PICTO. En taskmodel es required
      //TaskModel task = await getFixedTaskFromId(1);

      //taskImageUrl = 'assets/images/lavadora.png';
      //taskTitle = task.title;

      setState(() {
        initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const TopMenu(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Row with image and task
                Row(
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
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // 'Sin asignar alumnos' or Display Assignments
                selectedAssignments.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.01,
                        ),
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Grey
                          borderRadius:
                              BorderRadius.circular(8), // Border on circle
                          border:
                              Border.all(color: Colors.black), // Black border
                        ),
                        child: Center(
                          child: Text(
                            'Sin asignar alumnos',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          // Display Assignments content
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: selectedAssignments.length,
                            itemBuilder: (BuildContext context, int index) {
                              AssignmentsUser assignmentUser =
                                  selectedAssignments[index];
                              return ShowAssignmentsWidget(
                                assignmentUser: assignmentUser,
                                newAssignment: _selectDateTime,);
                            },
                          ),
                        ],
                      ),

                // GestureDetector con imagen
                GestureDetector(
                  onTap: showEstudiantePopup,
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
                const SizedBox(height: 60),
                // Button 'Guardar'
                ActionButton(
                  text: 'Confirmar',
                  type: 1,
                  onPressed: () {}
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> getStudentsNames() {
    List<String> studentsNames = [];
    for (UserModel student in students) {
      studentsNames.add(student.userName);
    }

    return studentsNames;
  }

  // On tap function for 'selection student' field
  void showEstudiantePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
          title: 'Estudiante',
          elements: getStudentsNames()
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedUser = students.firstWhere((user) => user.userName == result);

        print('Acabas de seleccionar el usuario con id: ${selectedUser!.id}');

        // Una vez he elegido el estudiante, me sale el popup de un calendario para elegir la fecha y la hora
        _selectDateTime();
      });
    }
  }

  void _handleConfirmation() async {
    showDialog(
      context: context,
      builder: (context) {
        return const LoadingDialog();
      },
    );
  }

  void _selectDateTime() async {
    BuildContext initialContext = context;
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: initialContext,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 1),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF9E9E9E),
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 62, 62, 62),
              onSurface: Colors.black,
            ),
            textTheme: const TextTheme(
              labelLarge: TextStyle(color: Colors.black),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      TimeOfDay selectedTime = (await showTimePicker(
            context: initialContext,
            initialTime: TimeOfDay.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: const Color(0xFF9E9E9E),
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF9E9E9E),
                    onSurface: Colors.black,
                  ),
                  textTheme: const TextTheme(
                    labelLarge: TextStyle(color: Colors.black),
                  ),
                ),
                child: child!,
              );
            },
          )) ??
          TimeOfDay.now();

      // Combine selectedDate and selectedTime into a single DateTime object
      DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      Pair<UserModel, DateTime> selectedAssignment =
          Pair<UserModel, DateTime>(selectedUser!, selectedDateTime);

      // Actualiza la lista de asignaciones de usuarios
      AssignmentsUser selectedAssignmentUser = AssignmentsUser(
        userName: selectedUser!.userName,
        userId: selectedUser!.id,
        dates: [selectedDateTime],
      );

      // Mostrar un popup para confirmar la asignación
      bool? confirmed = await showConfirmationDialog(context, selectedAssignment);

      // Añadir al array solo si se confirmó
      if (confirmed == true) {
        // Buscar si ya hay una asignación existente para este usuario
        int existingIndex = selectedAssignments.indexWhere(
          (assignmentUser) =>
              assignmentUser.userId == selectedAssignmentUser.userId,
        );

        setState(() {
          if (existingIndex != -1) {
            // Si ya existe, añadir la nueva fecha a las fechas existentes
            selectedAssignments[existingIndex].dates.add(selectedDateTime);
          } else {
            // Si no existe, añadir una nueva AssignmentsUser a la lista
            selectedAssignments.add(selectedAssignmentUser);
          }
        });
      }
    }
  }
}
