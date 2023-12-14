import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/assign_fixed_task_tab.dart';
import 'package:appcesible/screens/assign_fixed_task_app.dart';

class TaskAsign extends StatelessWidget{
  const TaskAsign({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return TaskAsignMobile();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return TaskAsignTablet();
      },
    );
  }
}