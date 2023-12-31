import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/task_list_app.dart';
import 'package:appcesible/screens/task_list_tab.dart';

class TaskListInit extends StatelessWidget {
  bool assignTask = true;

  TaskListInit({
    required this.assignTask,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<MyTaskData> tasks2 = [
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio y hacer los deberes',
        studentName: 'Juan Perez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio',
        studentName: 'Juan Perez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio',
        studentName: 'Juan Perez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'not done',
      ),
      MyTaskData(
        imagePath: 'assets/images/lavadora.png',
        imageStudent: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'not done',
      ),
    ];

    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return TaskListMobile(tasks: tasks2, assignTask: assignTask);
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return TaskListTablet(tasks: tasks2, assignTask: assignTask);
      },
    );
  }
}

// Auxiliar class for task data
class MyTaskData {
  final String imagePath;
  final String imageStudent;
  final String taskName;
  final String studentName;
  final String state;

  MyTaskData({
    required this.imagePath,
    required this.imageStudent,
    required this.taskName,
    required this.studentName,
    required this.state,
  });
}

void main() {}
