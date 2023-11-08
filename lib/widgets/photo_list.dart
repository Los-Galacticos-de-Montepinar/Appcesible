import 'package:flutter/material.dart';

class PhotoList extends StatelessWidget {
  const PhotoList({Key? key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      shrinkWrap: true, // Permite que el GridView se ajuste al contenido.
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Nombre',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _imageWidget(image: 'assets/images/alonso.png'),
            ],
          ),
        );
      },
    );
  }
}

Widget _imageWidget({required String image}) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
    ),
  );
}
