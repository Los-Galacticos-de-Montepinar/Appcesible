import 'package:appcesible/screens/create_task_material.dart';
import 'package:appcesible/screens/task_assignment.dart';
import 'package:appcesible/screens/task_list_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appcesible/screens/select_user.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 570), // ?
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MaterialTask(),
        );
      },
    );
  }
}
