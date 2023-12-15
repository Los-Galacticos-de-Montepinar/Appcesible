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
      backgroundColor: const Color(0xFFFFDC83),

      leading: IconButton(
        padding: const EdgeInsets.only(top: 10, bottom: 2, left: 10),
        icon: Column(
          children: <Widget>[
            const Icon(
              Icons.home_filled,
              size: 35.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Transform.translate(
              offset: const Offset(0, -3),
              child: const Text(
                'Inicio',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
        onPressed: () {
          // !!!!!!!!
        },
      ),
      // ! Se utiliza para poner texto a la derecha del titulo
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: PopupMenuButton(
            onSelected: (value) {
              if (value == "profile") {
                // add desired output
              }else if(value == "notifications"){
                // add desired output
              }else if(value == "logout"){
                userLogout();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const SelectUser();
                  }),
                  (route) => false
                );
              }
            },
            color: Colors.white,
            surfaceTintColor: Colors.white,
            position: PopupMenuPosition.under,
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: "profile",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.account_circle_rounded),
                    ),
                    Text(
                      'Mi perfil',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "notifications",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.notifications)
                    ),
                    Text(
                      'Notificaciones',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.logout)
                    ),
                    Text(
                      'Salir',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const Icon(
                Icons.menu,
                size: 40.0,
                color: Colors.black,
              ),
            ),
          )
        )
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(
        //       icon: const Icon(Icons.message),
        //       onPressed: () {},
        //       color: const Color.fromARGB(255, 0, 0, 0),
        //       constraints: const BoxConstraints(
        //           maxHeight:
        //               20), //* para limitar el tamaño del box del icono y que no salga del appbar
        //       padding: const EdgeInsets.only(
        //           top: 10,
        //           right:
        //               15), //* para que tenga espacio por arriba y a la derecha
        //     ),
        //     // IconButton(
        //     //   icon: const Icon(Icons.notifications),
        //     //   onPressed: () {},
        //     //   color: const Color.fromARGB(255, 0, 0, 0),
        //     //   //constraints: const BoxConstraints(maxHeight: 0),
        //     //   padding: const EdgeInsets.only(top: 10, right: 15),
        //     // )
        //   ],
        // )
      ],
    );
  }
}