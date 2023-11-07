import 'package:flutter/material.dart';

import 'students_list.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          onPressed: () {},
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
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),

            // * BOTON PERFIL *

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(134, 238, 238, 238)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Row(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Perfil',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // * BOTON ALUMNO *

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const StudentsList();
                  }));
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(134, 238, 238, 238)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Row(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Alumnos',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            //*BOTON TAREAS *

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(134, 238, 238, 238)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Row(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Tareas',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            //*BOTON CREAR TAREAS

            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(134, 238, 238, 238)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Row(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Crear Tareas',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            //* BOTON AÑADIR ALUMNO

            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(134, 238, 238, 238)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Row(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Añadir Alumno',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            //*BOTON MODIFICAR ALUMNO */

            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(134, 238, 238, 238)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Row(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Modificar Alumno',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(134, 238, 238, 238)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                  side: MaterialStateProperty.all(
                    const BorderSide(
                      width: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: const Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'EOIQUEIO Alumno',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
