import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/create_fixed_task_app.dart';
import 'package:appcesible/screens/create_fixed_task_tab.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CreateTaskInit extends StatelessWidget {
  const CreateTaskInit({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const CreateTaskMobile();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const CreateTaskTablet();
      },
    );
  }
}

void main() {
  // TASK CREATION
  
  // @override
  // Widget build(BuildContext context) {
  //  return ScreenUtilInit(
  //    designSize: const Size(412, 570),
  //    builder: (context, child) {
  //      return const MaterialApp(
  //        home: CreateTaskInit(),
  //      );
  //    },
  //  );
  // }
}
