import 'package:appcesible/screens/select_main.dart';
import 'package:appcesible/screens/step_check.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/screens/home_student.dart';

class TopMenuStudent extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String texto; // Nuevo atributo de texto
  final Function()? onHomeTap;

  const TopMenuStudent({super.key, required this.texto, this.onHomeTap})
      : preferredSize = const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      leadingWidth: 65.0,
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
        onPressed: onHomeTap ??
            () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeStudentInit()),
                  (route) => false);
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
      backgroundColor: const Color(0xFF9E9E9E),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StepCompletionCheckScreen(
                    image: "assets/images/salir.png",
                    texto: "¿Quieres Salir?",
                    destinationScreen: SelectMain(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
