import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserTab extends StatelessWidget {
  SelectUserTab({Key? key});

  List<String> imagenes = [
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopMenu(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: imagenes.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
                child: ClipOval(
                  child: _imageWidget(image: imagenes[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _imageWidget({required String image}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
