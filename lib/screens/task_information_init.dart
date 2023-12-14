import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:appcesible/screens/task_information_mobile.dart';
import 'package:appcesible/screens/task_information_tablet.dart';

class TaskInformation extends StatelessWidget{
  const TaskInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const TaskInformationMobile();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const TaskInformationTablet();
      },
    );
  }
}