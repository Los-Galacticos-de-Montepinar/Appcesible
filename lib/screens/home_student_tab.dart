// HOME STUDENT - Tablet Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:appcesible/widgets/widget_box_image_text.dart';
import 'package:appcesible/widgets/widget_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_student.dart';
import 'package:appcesible/screens/student_diary.dart';
import 'package:appcesible/screens/home_student_app.dart';

class HomeStudentTablet extends StatelessWidget {
  const HomeStudentTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const TopMenuStudent(texto: 'INICIO'),
        body: Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                ImageWidget(image: Image.asset('assets/images/alonso.png')),
                const SizedBox(height: 10.0),
                const Text(
                  'Bienvenido, NANO',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                const Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText1(
                        text: 'AGENDA',
                        color: Colors.red,
                        color2: Color.fromARGB(255, 234, 151, 161),
                        destinationScreen: StudentDiary(),),
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText1(
                        text: 'HISTORIAL',
                        color: Colors.blue,
                        color2: Color.fromARGB(255, 130, 172, 192),
                        destinationScreen: HomeStudent(),),
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText1(
                        text: 'CHATS',
                        color: Colors.green,
                        color2: Color.fromARGB(255, 150, 216, 135),
                        destinationScreen: HomeStudent(),),
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText1(
                        text: 'AGENDA',
                        color: Colors.orange,
                        color2: Color.fromARGB(255, 222, 175, 90),
                        destinationScreen: HomeStudent(),),
                    SizedBox(
                      width: 20.0,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
