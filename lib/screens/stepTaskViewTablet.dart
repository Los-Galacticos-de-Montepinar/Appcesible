import 'package:flutter/material.dart';

class stepTaskViewTablet extends StatelessWidget {
  final String text;
  final String image;
  final Widget destinationScreen;

  const stepTaskViewTablet({
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
        width: screenWidth * 0.62,
        height: screenHeight * 0.5,
        constraints: const BoxConstraints(
          minHeight:
              570.0, // Establece el minHeight deseado (en este caso, 500)
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
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 0),
                imageWidget(
                  image: 'assets/images/lavadora.png',
                  context: context,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Poner la ropa en la lavadora',
                        style: TextStyle(
                          fontSize: screenWidth * 0.025 + screenHeight * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
