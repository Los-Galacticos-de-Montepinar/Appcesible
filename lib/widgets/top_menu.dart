import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/screens/select_user.dart';
import 'package:flutter/material.dart';

import 'package:appcesible/command/session_command.dart';

class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const TopMenu({super.key}) : preferredSize = const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      toolbarHeight: 70,
      title: const Text(
        'AppCesible',
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 255, 220, 131),

      leading: IconButton(
        padding: const EdgeInsets.only(top: 10, bottom: 2, left: 10),
        icon: Column(
          children: <Widget>[
            const Icon(
              Icons.power_settings_new,
              size: 35,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Transform.translate(
              offset: const Offset(0, -3),
              child: const Text(
                'Salir',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        onPressed: () {
          userLogout();

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) {
              return const SelectUser();
            }),
            (route) => false);
        },
      ),
      // ! Se utiliza para poner texto a la derecha del titulo
      actions: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () {},
              color: const Color.fromARGB(255, 0, 0, 0),
              constraints: const BoxConstraints(
                  maxHeight:
                      20), //* para limitar el tamaño del box del icono y que no salga del appbar
              padding: const EdgeInsets.only(
                  top: 10,
                  right:
                      15), //* para que tenga espacio por arriba y a la derecha
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
              color: const Color.fromARGB(255, 0, 0, 0),
              //constraints: const BoxConstraints(maxHeight: 0),
              padding: const EdgeInsets.only(top: 10, right: 15),
            )
          ],
        )
      ],
    );
  }
}
