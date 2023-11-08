import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

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
    //final screenHeight = MediaQuery.of(context).size.height;

    //const heightPercentage = 0.12;
    //final heightTitle = screenHeight * heightPercentage;

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
                ],
              )),
            )));
  }
}
