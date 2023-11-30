import 'package:appcesible/command/session_command.dart';
import 'package:appcesible/screens/formulario_usuarios.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopMenu(),
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
                onPressed: () { // AQUI !!!!!!!
                  int userType = -1;
                  getSessionInformation().then((value) {
                    userType = value.getInt('userType')!;
                  });

                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                      return FormularioUsuarios(
                        'Editar perfil',
                        userType
                      );
                    })
                  );
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

            // BOTON CREAR TAREAS

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
                onPressed: () {
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                      return const FormularioUsuarios(
                        'Añadir alumno',
                        -1
                      );
                    })
                  );
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
                onPressed: () {
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                      return const FormularioUsuarios(
                        'Modificar alumno',
                        1
                      );
                    })
                  );
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
