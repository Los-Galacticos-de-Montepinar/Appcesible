import 'package:appcesible/models/class_model.dart';
import 'package:appcesible/widgets/button.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/services/media_service.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/widgets/input_dropdown.dart';
import 'package:appcesible/widgets/dialog_error.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:appcesible/widgets/upload_img.dart';

// Esto es una plantilla, para que sea la de añadir alumno, le pasais argumentos vacios, es decir, llamais al constructor
// FormularioAlumnos('','','',{},[],,'')
// si quereis editar,
// FormularioAlumnos('Titulo','Nombre','Contraseña',{mapa con el tipo de contenido},[lista de clases],indice
// de la clase a la que pertenece el alumnno,'enlace de la foto del alumno')
//
// El mapa es basicamente, si tenemos como tipos de contenido audio, texto y pictogramas, y el alumno solo usa el texto,
// su mapa será {'Audio':false,'Pictogramas':false,'Texto':true}, el índice es dentro de la lista que le pasamos,
// la lista de clases es ['3A','2A','1A'] y el alumno esta en 2A, el indice que pasamos es 1

void main() {
  runApp( 
    const MaterialApp(
      home: FormularioUsuarios('Añadir usuario',-1),
    )
  );

  // FORMULARIO USUARIO/ALUMNO

  // @override
  // Widget build(BuildContext context) {
  // return const FormularioAlumnos(
  //    'Añadir alumno',
  //   'Agustin',
  //  '123',
  // {'Audio': true, 'Pictogramas': false, 'Texto': false},
  // ['1A', '2A', '3A'],
  // 2,
  // '');
  // }
}

class FormularioUsuarios extends StatefulWidget {
  final String title;
  final int id;
  const FormularioUsuarios(this.title, this.id,{super.key});

  @override
  FormularioAlumnosState createState() => FormularioAlumnosState();
}

class FormularioAlumnosState extends State<FormularioUsuarios> {
  Function actionCall = (){};
  UserModel user = UserModel(
    id: -1,
    userName: '',
    userType: 0,
    idClass: 0
  );
  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwdController = TextEditingController();
  
  Map<String,bool> content = {'Texto':false,'Audio':false,'Imagenes':false};
  List<ClassModel> classes = [];
  final List<String> userTypes = ['Profesor','Estudiante','Administrador'];
  
  String choosedTypes = '';

  //bool firstExe=true;
  bool show=false;
  bool picto=false;

  DecorationImage picture=const DecorationImage(
    image: AssetImage('assets/images/addPicture.png'),
    fit: BoxFit.fill
  );

  bool _initialized = false;
  Future _initializeState() async {
    if (!_initialized) {
      actionCall = (widget.id == -1) ? createUser : updateUser;

    if (widget.id != -1) {
      user.id = widget.id;

      await getUserFromId(user.id).then((user) {
        this.user = user;
        _updateData('', {'Texto':false, 'Audio':false, 'Imagenes':false});
      });
    }

    classes = await getClasses();

      _initialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }
  
  void _updateData(String uPass, Map<String, bool> contentType) {
    setState(() {
      _nameController.text = user.userName;
      _passwdController.text = uPass;

      content = contentType;

      show = userTypes[user.userType]=='Estudiante';
      content.forEach((key, value) {
        if(value) choosedTypes+=' $key ';
      });
    });
  }

  @override
  void dispose () {
    _nameController.dispose();
    _passwdController.dispose();

    super.dispose();
  }

  List<String> _getClassesNames() {
    List<String> classesNames = [];
    for (ClassModel classModel in classes) {
      classesNames.add(classModel.className);
    }

    return classesNames;
  }

  int _getClassId(String name) {
    for (ClassModel classModel in classes) {
      if (classModel.className == name) {
        return classModel.id;
      }
    }

    return -1;
  }

  Widget passwdPic(){
    Image ejemplo=Image.asset('assets/images/addPicture.png');
    return ejemplo;
  }

  Widget passwdText(){
    return TextField(
      controller: _passwdController,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget pictoCheckWid(){
    return Row(
      children: [
        Checkbox(
            value: picto, 
            onChanged: (bool? value) {
              setState(() {
                picto = value!;
              });
            }, 
          ),
        const Text('Contraseña con pictogramas')
      ],
    );
  }  

  Widget contentW(BuildContext context){
    return Column(
      children: [Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text('Seleccionados: $choosedTypes'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: InputDropdown(
            name: 'Tipo de contenido',
            onElementSelected: (value) {
              setState(() {
                if (content.containsKey(value)) {
                  content[value] = !(content[value] ?? false);
                }
                choosedTypes = '';
                content.forEach((key, value) {
                  if(value) {
                    choosedTypes += ' $key ';
                  }
                });
              });
            },
            elements: content.keys.toList(),
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    Image defaultImage=Image.asset('assets/images/addPicture.png');

    return FutureBuilder(
      future: _initializeState(),
      builder: (content, snapshot) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            appBar: const TopMenu(),
            body: (_initialized || snapshot.connectionState == ConnectionState.done)
            ? Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.maxFinite,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: InputDropdown(
                          name: 'Tipo de usuario',
                          onElementSelected: (value) {
                            if (value != '') {
                              user.userType = userTypes.indexOf(value);
                              if (userTypes.contains('')) {
                                userTypes.remove('');
                                user.userType--;
                              }

                              show = user.userType==userTypes.indexOf('Estudiante');
                              setState(() {});
                            }
                          },
                          elements: userTypes,
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre Completo',
                            border: OutlineInputBorder(),
                          ),
                        )
                      ),
                      (picto && userTypes[user.userType] == 'Estudiante') ? passwdPic() : passwdText(),
                      show ? Container(child: pictoCheckWid()):const SizedBox.shrink(),
                      show ? Container(child: contentW(context)):const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: InputDropdown(
                          name: 'Clase',
                          onElementSelected: (value) {
                            setState(() {
                              user.idClass = _getClassId(value);
                            });
                          },
                          elements: _getClassesNames(),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: IconButton(
                          iconSize: 20,
                          icon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: (user.image != null) ? Image.file(user.image!).image : defaultImage.image,
                                  fit: BoxFit.fill)
                              ),
                              height: 192,
                              width: 192,
                              child: const ClipOval(),
                          ),
                          onPressed: () async {
                            var pickedImage = await UploadPicture.pickImage();

                            setState(() {
                              user.image = pickedImage;
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ActionButton(
                          text: 'Confirmar',
                          type: 1,
                          onPressed: () {
                            int cont = 0;
                            String msg = '';
                            if (_nameController.text.isEmpty) {
                              cont++;
                              msg = 'Rellene el campo nombre';
                            }
                            if (_passwdController.text.isEmpty) {
                              cont++;
                              msg = 'Rellene el campo contraseña';
                            }
                            if (userTypes[user.userType]=='') {
                              cont++;
                              msg = 'Rellene el campo tipo usuario';
                            }
                            if ((choosedTypes.isEmpty && userTypes[user.userType]=='Estudiante')) {
                              cont++;
                              msg = 'Rellene el campo contenidos';
                            }
                            if (user.idClass == -1) {
                              cont++;
                              msg = 'Rellene el campo clase';
                            }
                            if (user.image == null) {
                                cont++;
                                msg = 'Rellene el campo foto';
                            }
                            
                            if (cont > 0) {
                              if (cont > 1) msg = 'Faltan campos por rellenar';
                              ErrorWindow.showErrorDialog(context, msg);
                            }
                            else {
                              user.userName = _nameController.text;
                              actionCall(user, _passwdController.value.text);
                            }
                          },
                        ),
                      )
                    ],
                  )
              )
            )
            : const LoadingDialog(),
          )
        );
      }
    );
  }
}