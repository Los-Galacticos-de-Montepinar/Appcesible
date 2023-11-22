import 'package:appcesible/screens/select_user.dart';
import 'package:appcesible/widgets/new_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appcesible/screens/formulario_alumno.dart';
import 'package:appcesible/screens/home_teacher.dart';

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
          debugShowCheckedModeBanner: false,
          home: SelectUser(),
        );
      },
    );
  }

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
