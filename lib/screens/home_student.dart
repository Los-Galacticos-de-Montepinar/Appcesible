import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:appcesible/command/session_command.dart';
import 'package:appcesible/services/user_service.dart';

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
        return const HomeStudentApp();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const HomeStudentTab();
      },
    );
  }
}

abstract class HomeStudentState<T extends StatefulWidget> extends State<T> {
  late String userName;
  late Image profileImage;

  bool initialized = false;

  Future initialize() async {
    if (!initialized) {
      SharedPreferences sessionInfo = await getSessionInformation();
      userName = sessionInfo.getString('userName') ?? '';

      int userId = sessionInfo.getInt('id') ?? -1;
      profileImage = await getProfileImage(userId);
    }
  }
}
