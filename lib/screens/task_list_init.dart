import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:appcesible/screens/task_list_mobile.dart';
import 'package:appcesible/screens/task_list_tablet.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeStudentInit extends StatelessWidget {
  const HomeStudentInit({super.key});

  @override
  Widget build(BuildContext context) {

    List<MyTaskData> tasks2 = [
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio y hacer los deberes',
        studentName: 'Juan Perez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio',
        studentName: 'Juan Perez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio',
        studentName: 'Juan Perez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'not done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'not done',
      ),
    ];
  

    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return TaskListMobile(tasks: tasks2);
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return TaskListTablet(tasks: tasks2);
      },
    );
  }
}