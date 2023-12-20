import 'package:appcesible/command/session_command.dart';
import 'package:appcesible/screens/assign_fixed_task_app.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:flutter/material.dart';

import 'package:appcesible/screens/task_list.dart';
import 'package:appcesible/screens/create_user.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});
  
  @override
  State<StatefulWidget> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int _userType = -1;

  Future _initialize() async {
    SharedPreferences sessionInfo = await getSessionInformation();

    setState(() {
      _userType = sessionInfo.getInt('userType') ?? -1;
    });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

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

            // * BOTON ALUMNO *

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const TaskAsignMobile();
                  }));
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(const Color(0x85EEEEEE)),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
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
                      Icons.groups,
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const TaskListInit();
                    },
                  ));
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  alignment: Alignment.centerLeft,
                  minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                  backgroundColor: MaterialStateProperty.all(const Color(0x85EEEEEE)),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
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
                      Icons.checklist,
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

            Visibility(
              visible: (_userType == 2),
              child: Column(
                children: [
                  // BOTON CREAR TAREAS

                  const SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        alignment: Alignment.centerLeft,
                        minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                        backgroundColor: MaterialStateProperty.all(const Color(0x85EEEEEE)),
                        overlayColor: MaterialStateProperty.all(Colors.black12),
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
                            Icons.assignment_add,
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const FormularioUsuarios(
                              title: 'Añadir Usuario',
                              newUser: true,
                            );
                          })
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        alignment: Alignment.centerLeft,
                        minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                        backgroundColor: MaterialStateProperty.all(const Color(0x85EEEEEE)),
                        overlayColor: MaterialStateProperty.all(Colors.black12),
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
                            Icons.person_add,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Añadir Usuario',
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
                              title: 'Modificar Usuario',
                              newUser: false,
                            );
                          })
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        alignment: Alignment.centerLeft,
                        minimumSize: MaterialStateProperty.all(const Size(400, 80)),
                        backgroundColor: MaterialStateProperty.all(const Color(0x85EEEEEE)),
                        overlayColor: MaterialStateProperty.all(Colors.black12),
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
                            'Modificar Usuario',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
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
                  backgroundColor: MaterialStateProperty.all(const Color(0x85EEEEEE)),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
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

void main() {
  // HOME DEL PROFESOR

  // @override
  // Widget build(BuildContext context) {
  //  return const MaterialApp(
  //    home: TeacherHome(),
  //  );
  // }
}
