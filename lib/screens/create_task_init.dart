import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:appcesible/screens/create_task_mobile.dart';
import 'package:appcesible/screens/create_task_tablet.dart';
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