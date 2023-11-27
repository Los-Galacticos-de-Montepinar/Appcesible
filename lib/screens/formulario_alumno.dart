import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class FormularioAlumnos extends StatefulWidget {
  final String title;
  final String name;
  final String passwd;
  final Map<String, bool> content;
  final List<String> classes;
  final int classIndex;
  final String picture;
  const FormularioAlumnos(this.title, this.name, this.passwd, this.content,
      this.classes, this.classIndex, this.picture,
      {super.key});

  @override
  FormularioAlumnosState createState() => FormularioAlumnosState();
}

class FormularioAlumnosState extends State<FormularioAlumnos> {
  Map<String, bool> content = {};
  List<String> classes = [];
  int classIndex = -1;
  String choosedTypes = '';
  bool firstExe = true;
  DecorationImage picture = const DecorationImage(
      image: AssetImage('assets/images/addPicture.png'), fit: BoxFit.fill);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwdController.dispose();

    super.dispose();
  }

  void _showAlertDialog(String text) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: const Text('Alerta'),
            content: Text(text),
            actions: <Widget>[
              ElevatedButton(
                child: const Text(
                  'CERRAR',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;

    //const heightPercentage = 0.12;
    //final heightTitle = screenHeight * heightPercentage;

    if (firstExe) {
      nameController = TextEditingController(text: widget.name);

      passwdController = TextEditingController(text: widget.passwd);

      content = Map.fromIterables(widget.content.keys, widget.content.values);
      classes = widget.classes;
      classIndex = widget.classIndex;

      content.forEach((key, value) {
        if (value) choosedTypes += ' $key ';
      });

      if (widget.picture != '') {
        //picture=DecorationImage(image: NetworkImage(widget.picture));
      }

      firstExe = false;
    }

    return MaterialApp(
        home: Scaffold(
            appBar: const TopMenu(),
            body: Center(
                child: SingleChildScrollView(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.title,
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
                  child: Text('Seleccionados: $choosedTypes'),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: DropdownButtonFormField(
                    items: content.keys
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => {
                      if (value != null && content.containsKey(value))
                        content[value] = !(content[value] ?? false),
                      choosedTypes = '',
                      content.forEach((key, value) {
                        if (value) {
                          choosedTypes += ' $key ';
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
                    items: classes
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => {
                      if (value != null) {classIndex = classes.indexOf(value)}
                    },
                    value: classes[classIndex],
                    decoration: const InputDecoration(labelText: 'Clase'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, image: picture),
                          height: 256,
                          width: 256,
                          child: const ClipOval(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton(
                              onPressed: () => {},
                              child: const Text('Subir Foto')),
                        )
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(22),
                    child: TextButton(
                        onPressed: () => {
                              if (nameController.value.text.isEmpty)
                                _showAlertDialog('Rellene el campo nombre')
                              else if (passwdController.value.text.isEmpty)
                                _showAlertDialog('Rellene el campo contraseña')
                              else if (choosedTypes.isEmpty)
                                _showAlertDialog('Rellene el campo contenidos')
                              else if (classIndex == -1)
                                _showAlertDialog('Rellene el campo clase')
                              else if ((picture.image as AssetImage)
                                      .assetName ==
                                  'assets/images/addPicture.png')
                                _showAlertDialog('Rellene el campo foto')
                              //else
                              //  subirDatos
                            },
                        child: const Text('Finalizar')))
              ],
            )))));
  }
}
