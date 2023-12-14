import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:appcesible/screens/task_asign_tablet.dart';
import 'package:appcesible/screens/task_asign_mobile.dart';

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