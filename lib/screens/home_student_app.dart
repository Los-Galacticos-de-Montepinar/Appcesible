// HOME STUDENT - Mobile Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:appcesible/widgets/widget_top_student.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/screens/student_diary.dart';

class HomeStudent extends StatelessWidget {
  const HomeStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const TopMenuStudent(texto: 'INICIO'),
        body: Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                const Text(
                  'Bienvenido, CABRA ASTURIANA',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 4.0,
                    ),
                  ),
                  child: ClipOval(
                    child: imageWidget(image: 'assets/images/alonso.png'),
                  ),
                ),
                const SizedBox(height: 40),
                const Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'AGENDA',
                        color: Colors.red,
                        color2: Color.fromARGB(255, 234, 151, 161),
                        destinationScreen: StudentDiary(),),
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'HISTORIAL',
                        color: Colors.blue,
                        color2: Color.fromARGB(255, 130, 172, 192),
                        destinationScreen: HomeStudent(),),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'CHATS',
                        color: Colors.green,
                        color2: Color.fromARGB(255, 150, 216, 135),
                        destinationScreen: HomeStudent(),),
                    SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'AGENDA',
                        color: Colors.orange,
                        color2: Color.fromARGB(255, 222, 175, 90),
                        destinationScreen: HomeStudent(),),
                    SizedBox(
                      width: 20.0,
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}

// Class designed to create a box containing both text and an image
class MyBoxWithImageAndText extends StatelessWidget {
  final String text;
  final Color color;
  final Color color2;
  final Widget destinationScreen;

  const MyBoxWithImageAndText(
      {super.key,
      required this.text,
      required this.color,
      required this.color2,
      required this.destinationScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla de destino cuando se toca la caja
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        height: 186,
        width: 186,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
          color: color2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style:
                  const TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            ),
            Container(
              child: imageWidget(image: 'assets/images/agenda.png'),
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
