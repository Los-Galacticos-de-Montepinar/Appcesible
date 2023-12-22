import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/students_list_app.dart';
import 'package:appcesible/screens/students_list_tablet.dart';

class StudentsListInit extends StatelessWidget {
  const StudentsListInit({super.key});

  @override
  Widget build(BuildContext context) {
    List<MyStudentData> tasks2 = [
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Juan Perez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Maria Rodriguez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Carlos Lopez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Juan Perez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Maria Rodriguez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Carlos Lopez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Juan Perez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Maria Rodriguez',
      ),
      MyStudentData(
        imageStudent: 'assets/images/gato.png',
        clase: '1ºC',
        studentName: 'Carlos Lopez',
      ),
    ];

    bool assignTask = false;

    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return StudentListMobile(tasks: tasks2, assignTask: assignTask);
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return StudentListTablet(tasks: tasks2, assignTask: assignTask);
      },
    );
  }
}

// Auxiliar class for task data
class MyStudentData {
  final String imageStudent;
  final String clase;
  final String studentName;

  MyStudentData({
    required this.imageStudent,
    required this.clase,
    required this.studentName,
  });
}

void main() {}
