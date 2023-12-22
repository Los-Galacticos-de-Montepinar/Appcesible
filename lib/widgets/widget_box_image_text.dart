import 'package:flutter/material.dart';

// Class designed to create a box containing both text and an image
class MyBoxWithImageAndText1 extends StatelessWidget {
  final String text;
  final Color color;
  final Color color2;
  final Widget destinationScreen;
  final String imagen;

  const MyBoxWithImageAndText1(
      {super.key,
      required this.text,
      required this.color,
      required this.color2,
      required this.destinationScreen,
      required this.imagen});

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
        height: 188,
        width: 188,
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
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Container(
              child: imageWidget(image: imagen),
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
