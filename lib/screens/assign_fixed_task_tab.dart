import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/item_list.dart';
import 'package:appcesible/widgets/search_bar.dart';

import 'package:appcesible/services/user_service.dart';

import 'package:appcesible/models/user_model.dart';

class TaskAsignTablet extends StatefulWidget {
  const TaskAsignTablet({super.key});

  @override
  State<TaskAsignTablet> createState() => _TaskAsignTabletState();
}

class _TaskAsignTabletState extends State<TaskAsignTablet> {
  final TextScaler titleSize = const TextScaler.linear(2.5);
  final Color lightGrey = Colors.grey.shade300;
  final Color darkGrey = Colors.grey.shade400;
  final EdgeInsetsGeometry myPad12 = const EdgeInsets.all(12);
  final EdgeInsetsGeometry myPad8 = const EdgeInsets.all(12);

  //Para controlar la barra de busqueda de alumnos
  TextEditingController alumnSearch = TextEditingController();
  //Aqui guardo los alumnos seleccionados para la tarea
  List<String> selected = List.empty(growable: true);
  //Aqui voy a guardar las clases, que las tengo qwe descargar de la BD,
  //las usare para hacer los filtros por clase
  List<String> classList = List.empty(growable: true);
  Container resultadosBusqueda = Container();

  bool _initialized = false;
  List<String> alumnos = [];

  @override
  void initState() {
    super.initState();

    resultadosBusqueda = Container(margin: myPad12, height: 375);

    classList.add("3A");
    classList.add("2A");
    classList.add("1A");
  }

  /// Construye el container de la caja cuadrada gris
  Container elementBox(
      Size screenSize, String text, Color myColor, EdgeInsetsGeometry pad) {
    return Container(
      width: screenSize.width * 0.45,
      margin: pad,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), color: myColor),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(text, textScaler: titleSize, textAlign: TextAlign.center),
      ),
    );
  }

  // Container de los alumnos en la busqueda
  Container searchResult(Size screenSize, String search) {
    List<String> alumnosFilt = alumnos
        .where(
            (element) => element.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Container(
        margin: myPad12,
        height: screenSize.height * 0.55,
        child: ItemListWidget(
          elements: alumnosFilt,
          onItemTap: (name) {
            if (!selected.contains(name)) {
              setState(() {
                selected.add(name);
              });
            }
          },
        ));
  }

  Future _initializeState() async {
    if (!_initialized) {
      alumnos = await alumnBDpetition();

      _initialized = true;
    }
  }

  // Esta funcion descarga a los alumnos de la DB y devuelve un map con nombre e id
  Future<List<String>> alumnBDpetition() async {
    List<UserModel> peticionBD = [];
    List<String> res = [];

    peticionBD = await getAllStudents(false);
    for (int i = 0; i < peticionBD.length; ++i) {
      res.add(peticionBD[i].userName);
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _initializeState(),
        builder: (context, snapshot) {
          return Scaffold(
              appBar: TopMenu(onHomeTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                          message:
                              '¿Está seguro de que quiere abandonar el proceso?\nLos datos introducidos hasta el momento se perderán',
                          onConfirm: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) {
                              return const TeacherHome();
                            }), (route) => false);
                          });
                    });
              }),
              body: (_initialized ||
                      snapshot.connectionState == ConnectionState.done)
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                /**
                       * Parte izquierda
                       */
                                Container(
                                    width: screenSize.width * 0.48,
                                    margin: myPad12,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          /**
                               * Conatiner con la foto de la tarea y su nombre
                               */
                                          SizedBox(
                                              height: screenSize.height * 0.22,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    // Foto
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Image.asset(
                                                          "assets/images/alonso.png",
                                                          height: screenSize
                                                                  .height *
                                                              0.2,
                                                        )),

                                                    // Nombre de la tarea
                                                    SizedBox(
                                                      width: screenSize.width *
                                                          0.3,
                                                      child: Text(
                                                          "Poner lavadora",
                                                          textAlign:
                                                              TextAlign.center,
                                                          textScaler:
                                                              titleSize),
                                                    )
                                                  ],
                                                ),
                                              )),
                                          /**
                               * Barra del medio horizontal
                               */
                                          Container(
                                            height: screenSize.height * 0.001,
                                            width: screenSize.width * 0.45,
                                            decoration: const BoxDecoration(
                                                color: Colors.black),
                                          ),
                                          /**
                               * Lista de alumnos asignados
                               */
                                          SingleChildScrollView(
                                            child: Container(
                                                margin: myPad12,
                                                height:
                                                    screenSize.height * 0.575,
                                                width: screenSize.width * 0.45,
                                                /**
                                   * Lista de alumnos con la tarea asignada
                                   */
                                                child: SingleChildScrollView(
                                                    child: ItemListWidget(
                                                  elements: selected,
                                                  onItemTap: (name) {
                                                    selected.removeWhere(
                                                        (element) =>
                                                            element == name);
                                                    setState(() {});
                                                  },
                                                ))),
                                          )
                                        ],
                                      ),
                                    )),
                                /**
                       * Barra del medio
                       */
                                Container(
                                  height: screenSize.height * 0.82,
                                  width: screenSize.width * 0.001,
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                ),
                                /**
                       * Parte derecha
                       */
                                Container(
                                  width: screenSize.width * 0.48,
                                  margin: myPad12,
                                  child: Column(
                                    children: [
                                      /**
                             * Titulo de la lista de alumnos
                             */
                                      elementBox(screenSize, "Lista de alumnos",
                                          darkGrey, myPad12),
                                      /**
                             * Barra de busqueda
                             */
                                      SearchBarWidget(
                                          title: "alumnos",
                                          onTextChanged: (search) {
                                            resultadosBusqueda = searchResult(
                                                screenSize, search);
                                            setState(() {});
                                          }),
                                      /**
                             * Lista de alumnos encontrados
                             */
                                      resultadosBusqueda
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /**
                  * Boton de confirmar cambios
                  */
                          Container(
                            margin: myPad8,
                            child: FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    minimumSize: Size(screenSize.width * 0.6,
                                        screenSize.height * 0.05),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2))),
                                onPressed: () {
                                  /**
                       * INSERTAR FUNCION PARA SUBIR LOS ASIGNADOS DE LA TAREA EN LA BD
                       */
                                },
                                child: const Text("Confirmar")),
                          )
                        ],
                      ),
                    )
                  : const LoadingDialog());
        });
  }
}
