import 'package:appcesible/screens/task_student_app.dart';
import 'package:appcesible/screens/task_student_tab.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screenutil_init.dart';


class TaskStudentInit extends StatelessWidget {
  const TaskStudentInit({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const StudentTaskApp();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const StudentTaskTablet();
      },
    );
  }
}


void main() {

}