import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:appcesible/widgets/my_checkbox.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  MyStatefulWidgetState createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  UserModel? _user;

  List<String> tipos = [];
  List<bool> tiposV = [];
  Map<String, bool> mapa = {};
  String seleccionados = '';
  List<String> clases = [];
  int claseSelec = -1;

  final nameController = TextEditingController();
  final passwdController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  MyStatefulWidgetState() {
    tipos = ['Audio', 'Texto', 'Pictogramas'];
    tiposV = List.filled(tipos.length, false);
    mapa = Map.fromIterables(tipos, tiposV);
    clases = ['1A', '2A', '3A'];
  }

  @override
  void dispose() {
    nameController.dispose();
    passwdController.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const heightPercentage = 0.12;
    final heightTitle = screenHeight * heightPercentage;
    final heightContainer = (screenHeight * (1 - heightPercentage)) - 10;

    return MaterialApp(
        home: Scaffold(
            appBar: const TopMenu(),
            body: Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Variable',
                        textScaleFactor: 2,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre Completo',
                          border: OutlineInputBorder(),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: passwdController,
                        decoration: const InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('Seleccionados: $seleccionados'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField(
                      items: tipos
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => {
                        if (value != null && mapa.containsKey(value))
                          mapa[value] = !(mapa[value] ?? false),
                        seleccionados = '',
                        mapa.forEach((key, value) {
                          if (value) {
                            seleccionados += ' $key ';
                          }
                        }),
                        setState(() {})
                      },
                      decoration:
                          const InputDecoration(labelText: 'Tipo de contenido'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField(
                      items: clases
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => {
                        if (value != null) {claseSelec = clases.indexOf(value)}
                      },
                      decoration: const InputDecoration(labelText: 'Clase'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Fecha seleccionada: ${_selectedDate.toString().substring(0, 10)}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: const Text('Seleccionar fecha de nacimiento'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(children: [MyCheckbox(), MyCheckbox()])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                        onPressed: () {
                          UserModel user = UserModel(
                              id: 5,
                              userName: nameController.text,
                              idProfileImg: 5,
                              userType: 5,
                              idClass: claseSelec,
                              age: 12);

                          createUser(user, passwdController.text);
                        },
                        child: const Text('Submit')),
                  )
                ],
              )),
            )));
  }
}
