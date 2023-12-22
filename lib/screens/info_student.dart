import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/info_student_app.dart';
import 'package:appcesible/screens/info_student_tab.dart';

class StudentInformation extends StatelessWidget{
  const StudentInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const StudentInformationMobile();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const StudentInformationTablet();
      },
    );
  }
}