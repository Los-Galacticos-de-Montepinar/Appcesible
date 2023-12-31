import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/widgets/date_time_picker.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:flutter/material.dart';
import 'package:pair/pair.dart';

import 'package:appcesible/models/assigments_user.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/services/user_service.dart';

import 'package:appcesible/widgets/dialog_list_assign.dart';
import 'package:appcesible/widgets/dialog_list_search.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_assign.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:appcesible/widgets/button.dart';

class TaskAsignMobile extends StatefulWidget {
  // final TaskModel task;
  
  const TaskAsignMobile({super.key, /*required this.task*/});

  @override
  State<TaskAsignMobile> createState() => _TaskAsignMobileState();
}

class _TaskAsignMobileState extends State<TaskAsignMobile> {
  // Variables para la tarea
  String taskImageUrl = 'assets/images/lavadora.png'; // Image url task default
  String taskTitle = 'Poner Lavadora';

  UserModel? selectedUser;

  List<UserModel> students = [];
  List<UserModel> teachers = [];
  bool initialized = false;

  List<AsignmentsUser> selectedAssignments = [];

  TextEditingController searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future initializeState() async {
    if (!initialized) {
      List<UserModel> users = await getAllUsers(false);

      teachers = users.where((user) => user.userType != 1).toList();
      students = users.where((user) => user.userType == 1).toList();

      // NO LO HE HECHO, ERROR EN DATOS DE BD, NULL EN ID_PICTO. En taskmodel es required
      //TaskModel task = await getFixedTaskFromId(1);

      //taskImageUrl = 'assets/images/lavadora.png';
      //taskTitle = task.title;

      initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeState(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: TopMenu(
            onHomeTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                    message: '¿Está seguro de que quiere abandonar el proceso?\nLos datos introducidos hasta el momento se perderán',
                    onConfirm: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return const TeacherHome();
                          }
                        ),
                        (route) => false
                      );
                    }
                  );
                }
              );
            },
          ),
          body: (initialized && snapshot.connectionState == ConnectionState.done)
            ? SingleChildScrollView(
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
                    
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: showEstudiantePopup,
                          icon: const Icon(
                            Icons.group_add,
                            size: 40.0,
                            color: Colors.black,
                          )
                        )
                      ],
                    ),

                    const SizedBox(height: 20.0,),

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
                                  AsignmentsUser assignmentUser =
                                      selectedAssignments[index];
                                  int numAssignments = getNumAssignmentsForUser(
                                      selectedAssignments, assignmentUser.userId);
                                  return ShowAsignmentsWidget(
                                    asignmentUser: assignmentUser,
                                    newAsignment: _selectDateTime,
                                    numAsignments: numAssignments,
                                  );
                                },
                              ),
                            ],
                          ),

                    const SizedBox(height: 60),
                    // Button 'Guardar'
                    ActionButton(text: 'Confirmar', type: 1, onPressed: () {}),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
            : const LoadingDialog(),
        );
      }
    );
  }

  List<String> getStudentsNames() {
    List<String> studentsNames = [];
    for (UserModel student in students) {
      studentsNames.add(student.userName);
    }

    return studentsNames;
  }

  int getNumAssignmentsForUser(List<AsignmentsUser> assignments, int userId) {
    int numAssignments = 0;

    for (AsignmentsUser assignment in assignments) {
      if (assignment.userId == userId) {
        numAssignments += assignment.dates.length;
      }
    }

    return numAssignments;
  }

  // On tap function for 'selection student' field
  void showEstudiantePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
          title: 'Estudiante',
          label: 'Estudiante',
          elements: getStudentsNames()
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedUser = students.firstWhere((user) => user.userName == result);

        print('Acabas de seleccionar el usuario con id: ${selectedUser?.id}');

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
    DateTime? date = await DateTimePicker.selectDate(context);
    if (date == null) {
      return;
    }

    TimeOfDay? time = await DateTimePicker.selectTime(context);
    if (time == null) {
      return;
    }

    // Combine selectedDate and selectedTime into a single DateTime object
    DateTime selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    Pair<UserModel, DateTime> selectedAssignment = Pair<UserModel, DateTime>(selectedUser!, selectedDateTime);

    // Actualiza la lista de asignaciones de usuarios
    AsignmentsUser selectedAssignmentUser = AsignmentsUser(
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
          // Si no existe, añadir una nueva AsignmentsUser a la lista
          selectedAssignments.add(selectedAssignmentUser);
        }
      });
    }
  }
}