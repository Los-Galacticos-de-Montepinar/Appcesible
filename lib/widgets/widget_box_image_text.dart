import 'package:flutter/material.dart';

// Class designed to create a box containing both text and an image
class MyBoxWithImageAndText1 extends StatelessWidget {
  final String text;
  final Color color;
  final Color color2;
  final Widget destinationScreen;

  const MyBoxWithImageAndText1(
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

// Class designed to create a box containing both text and an image
class MyBoxWithImageAndText2 extends StatelessWidget {
  final String text;
  final String image;
  final Widget destinationScreen;

  const MyBoxWithImageAndText2(
      {super.key,
      required this.text,
      required this.image,
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
        height: 530,
        width: 270,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.grey[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Text(
              'TAREA',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Container(
              child: imageWidget(image: image),
            ),
            SizedBox(
              height: 120,
              child: SingleChildScrollView(
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //

            //),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 260,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.contain)),
    );
  }
}