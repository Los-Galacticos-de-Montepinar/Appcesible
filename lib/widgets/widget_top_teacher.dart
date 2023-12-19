import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:flutter/material.dart';

import 'package:appcesible/command/session_command.dart';
import 'package:appcesible/services/user_service.dart';

import 'package:appcesible/screens/create_user.dart';
import 'package:appcesible/screens/select_user.dart';

class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Function() onHomeTap;

  const TopMenu({
    super.key,
    required this.onHomeTap
  }) : preferredSize = const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      toolbarHeight: 70,
      title: const Text(
        'AppCesible',
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 32.0,
          fontWeight: FontWeight.bold
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xFFFFDC83),
      leadingWidth: 65.0,
      leading: IconButton(
        alignment: Alignment.center,
        // padding: const EdgeInsets.only(left: 12),
        icon: Column(
          children: [
            const Icon(
              Icons.home_filled,
              size: 32.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Transform.translate(
              offset: const Offset(1, 0),
              child: const Text(
                'Inicio',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0
                ),
              ),
            ),
          ],
        ),
        onPressed: onHomeTap,
      ),
      // ! Se utiliza para poner texto a la derecha del titulo
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: PopupMenuButton(
            onSelected: (value) async {
              NavigatorState navigator = Navigator.of(context);

              if (value == 'profile') {
                int userId = -1;
                await getSessionInformation().then((value) {
                  userId = value.getInt('id')!;
                });

                navigator.push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return FormularioUsuarios(
                      title: 'Editar Perfil',
                      id: userId,
                      newUser: false,
                    );
                  })
                );
              }
              else if (value == 'notifications'){
                // add desired output
              }
              else if (value == 'logout'){
                showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmationDialog(
                      message: '¿Quieres cerrar sesión?',
                      onConfirm: () async {
                        bool logout = await logOutUser();

                        if (logout) {
                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const SelectUser();
                            }),
                            (route) => false
                          );
                        }
                      },
                    );
                  }
                );
              }
            },
            color: Colors.white,
            surfaceTintColor: Colors.white,
            position: PopupMenuPosition.under,
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'profile',
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
                value: 'notifications',
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
                value: 'logout',
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