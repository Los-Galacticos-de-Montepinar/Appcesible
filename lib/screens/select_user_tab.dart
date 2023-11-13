import 'package:appcesible/widgets/photo_list.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserTab extends StatelessWidget {
  const SelectUserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopMenu(),
        body: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Inicio de Sesión',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5), child: PhotoList()),
            FittedBox(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      topRight: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.subdirectory_arrow_left_outlined,
                      size: 38,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Volver',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _imageWidget({required String image}) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}