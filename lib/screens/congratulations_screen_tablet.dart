// CONGRATULATIONS SCREEN - Mobile Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:appcesible/screens/task_student.dart';
import 'package:appcesible/widgets/widget_top_student.dart';
import 'package:flutter/material.dart';

class CongratulationsScreenTablet extends StatelessWidget {
  const CongratulationsScreenTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const TopMenuStudent(texto: "FIN TAREA"),
        body: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                children: <Widget>[
                  MyBoxWithImageAndText(
                    color: Colors.black,
                    color2: Color.fromRGBO(152, 202, 157, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBoxWithImageAndText extends StatelessWidget {
  final Color color;
  final Color color2;

  const MyBoxWithImageAndText({
    super.key,
    required this.color,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StudentTask()),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.70,
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
              "FELICIDADES",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: imageWidget2(
                    image: 'assets/images/confeti.png',
                    context: context,
                  ),
                ),
                const SizedBox(width: 40),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: imageWidget2(
                    image: 'assets/images/confeti.png',
                    context: context,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.16,
              child: imageWidget(
                image: 'assets/images/trofeo.png',
                context: context,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "LO LOGRASTE !!!!!",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget({required String image, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget imageWidget2({required String image, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
