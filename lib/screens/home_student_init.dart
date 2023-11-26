import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:appcesible/screens/home_student_mobile.dart';
import 'package:appcesible/screens/home_student_tablet.dart';
import 'package:appcesible/screens/home_student_web.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
      desktop: (context) {
        ScreenUtilBreakpoints.initWebDesignSize(context);
        return const HomeStudentWeb();
      },
    );
  }
}