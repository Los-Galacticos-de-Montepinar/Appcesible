import 'package:flutter/material.dart';
import 'package:appcesible/screens/home_student.dart';

class TopMenuStudent extends StatelessWidget implements PreferredSizeWidget {
  final Size preferredSize;
  final String texto; // Nuevo atributo de texto

  const TopMenuStudent({Key? key, required this.texto})
      : preferredSize = const Size.fromHeight(80.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      toolbarHeight: 80,
      leading: IconButton(
        padding: const EdgeInsets.only(top: 10, bottom: 2, left: 10),
        icon: Column(
          children: <Widget>[
            const Icon(
              Icons.home_filled,
              size: 45.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Transform.translate(
              offset: const Offset(0, 3),
              child: const Text(
                'INICIO', // Utiliza el atributo de texto aquí
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeStudentInit()),
          );
        },
      ),
      title: Text(
        texto, // Utiliza el atributo de texto aquí
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[400],
      actions: [
        IconButton(
          padding: const EdgeInsets.only(top: 10, bottom: 2, right: 10),
          icon: Column(
            children: <Widget>[
              const Icon(
                Icons.power_settings_new,
                size: 45.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Transform.translate(
                offset: const Offset(0, 0),
                child: const Text(
                  'SALIR', // Utiliza el atributo de texto aquí
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          onPressed: () {
            // !!!!!!!!
          },
        ),
      ],
    );
  }
}
