import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appcesible/screens/task_list_mobile.dart';
import 'package:appcesible/screens/create_task_init.dart';
import 'package:appcesible/screens/home_student_init.dart';
import 'package:appcesible/screens/formulario_alumno.dart';
import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/screens/select_user.dart';
import 'package:appcesible/widgets/new_step.dart';

import 'package:appcesible/widgets/top_menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // SELECCION DE USUARIO !!!!!

  @override
  Widget build(BuildContext context) {

    List<MyTaskData> tasks2 = [
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio y hacer los deberes',
        studentName: 'Juan Perez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio',
        studentName: 'Juan Perez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Hacer ejercicio',
        studentName: 'Juan Perez',
        state: 'not finished',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Estudiar para el examen',
        studentName: 'Maria Rodriguez',
        state: 'not done',
      ),
      MyTaskData(
        imagePath: 'assets/images/gato.png',
        taskName: 'Completar proyecto',
        studentName: 'Carlos Lopez',
        state: 'not done',
      ),
    ];

    return ScreenUtilInit(
      designSize: const Size(412, 570),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TaskListMobile(tasks: tasks2),
        );
      },
    );
  }

  // TASK CREATION
  
  //@override
  //Widget build(BuildContext context) {
  //  return ScreenUtilInit(
  //    designSize: const Size(412, 570),
  //    builder: (context, child) {
  //      return const MaterialApp(
  //        debugShowCheckedModeBanner: false,
  //        home: CreateTaskInit(),
  //      );
  //    },
  //  );
  //}  

  // HOME USUARIO
  
  //@override
  //Widget build(BuildContext context) {
  //  return ScreenUtilInit(
  //    designSize: const Size(412, 570),
  //    builder: (context, child) {
  //      return const MaterialApp(
  //        debugShowCheckedModeBanner: false,
  //        home: HomeStudentInit(),
  //      );
  //    },
  //  );
  //}

  // SELECCION DE USUARIO
  
  //@override
  //Widget build(BuildContext context) {
  //  return ScreenUtilInit(
  //    designSize: const Size(412, 570), // ?
  //    builder: (context, child) {
  //      return const MaterialApp(
  //        debugShowCheckedModeBanner: false,
  //        home: SelectUser(),
  //      );
  //    },
  //  );
  //}

  // HOME DEL PROFESOR

  //@override
  //Widget build(BuildContext context) {
  //  return const MaterialApp(
  //    //debugShowCheckedModeBanner: false,
  //    home: TeacherHome(),
  //  );
  //}

  // FORMULARIO USUARIO/ALUMNO
  //
  // Esto es una plantilla, para que sea la de añadir alumno, le pasais argumentos vacios, es decir, llamais al constructor
  // FormularioAlumnos('','','',{},[],,'')
  // si quereis editar,
  // FormularioAlumnos('Titulo','Nombre','Contraseña',{mapa con el tipo de contenido},[lista de clases],indice
  // de la clase a la que pertenece el alumnno,'enlace de la foto del alumno')
  //
  // El mapa es basicamente, si tenemos como tipos de contenido audio, texto y pictogramas, y el alumno solo usa el texto,
  // su mapa será {'Audio':false,'Pictogramas':false,'Texto':true}, el índice es dentro de la lista que le pasamos,
  // la lista de clases es ['3A','2A','1A'] y el alumno esta en 2A, el indice que pasamos es 1

  //@override
  //Widget build(BuildContext context) {
  // return const FormularioAlumnos(
  //    'Añadir alumno',
  //   'Agustin',
  //  '123',
  // {'Audio': true, 'Pictogramas': false, 'Texto': false},
  //['1A', '2A', '3A'],
  // 2,
  // '');
  // }
}