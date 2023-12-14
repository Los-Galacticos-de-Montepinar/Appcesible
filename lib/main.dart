import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appcesible/screens/task_asign_init.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // SELECCION DE USUARIO
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskAsign(),
    );
  }
}
