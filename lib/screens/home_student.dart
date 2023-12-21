import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/home_student_app.dart';
import 'package:appcesible/screens/home_student_tab.dart';

class HomeStudentInit extends StatelessWidget {
  const HomeStudentInit({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const HomeStudent();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const HomeStudentTablet();
      },
    );
  }
}
