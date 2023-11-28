// HOME STUDENT - Mobile Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:flutter/material.dart';


class HomeStudent extends StatelessWidget {
  const HomeStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Column(
              children: [
                Icon(Icons.home, color: Colors.black),
                Text('INICIO',
                    style: TextStyle(color: Colors.black, fontSize: 11))
              ],
            ),
            onPressed: () {
              // Logic for the left action button
            },
          ),
          title: const Text(
            'HOME',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[400],
          actions: [
            IconButton(
              icon: const FittedBox(
                child: Column(
                  children: [
                    Icon(Icons.power_settings_new, color: Colors.black),
                    Text(
                      'SALIR',
                      style: TextStyle(color: Colors.black, fontSize: 11),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                // Logic for the right action button
              },
            ),
          ],
        ),
        body: Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                const Text(
                  'Bienvenido, NANO',
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
                Row(
                  children: [
                    const SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'AGENDA',
                        color: Colors.red,
                        color2: const Color.fromARGB(255, 234, 151, 161)),
                    const SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'HISTORIAL',
                        color: Colors.blue,
                        color2: const Color.fromARGB(255, 130, 172, 192)),
                    const SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'CHATS',
                        color: Colors.green,
                        color2: const Color.fromARGB(255, 150, 216, 135)),
                    const SizedBox(
                      width: 20.0,
                    ),
                    MyBoxWithImageAndText(
                        text: 'AGENDA',
                        color: Colors.orange,
                        color2: const Color.fromARGB(255, 222, 175, 90)),
                    const SizedBox(
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

  MyBoxWithImageAndText(
      {required this.text, required this.color, required this.color2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add the logic here for when the box is tapped
      },
      child: Container(
        height: 182,
        width: 182,
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
