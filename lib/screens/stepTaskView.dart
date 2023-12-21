import 'package:flutter/material.dart';

class stepTaskView extends StatelessWidget {
  final String text;
  final String image;
  final Widget destinationScreen;

  const stepTaskView({
    Key? key,
    required this.text,
    required this.image,
    required this.destinationScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén el ancho y alto de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        width: screenWidth,
        height: screenHeight * 0.6,
        constraints: const BoxConstraints(
          minHeight:
              500.0, // Establece el minHeight deseado (en este caso, 500)
        ),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.grey[400],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PASO 1',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 20),
                imageWidget(
                  image: 'assets/images/lavadora.png',
                  context: context,
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Poner la ropa en la lavadora.',
                        style: TextStyle(
                          fontSize: screenWidth * 0.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget({
    required String image,
    required BuildContext context,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.35,
      width: screenWidth * 0.3,
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
