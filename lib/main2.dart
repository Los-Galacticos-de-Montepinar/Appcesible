import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appcesible/screens/home_student.dart';
import 'package:appcesible/screens/student_diary_init.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // SELECCION DE USUARIO
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 570), // ?
      builder: (context, child) {
        return const MaterialApp(
          home: StudentDiaryInit(),
        );
      },
    );
  }
}
