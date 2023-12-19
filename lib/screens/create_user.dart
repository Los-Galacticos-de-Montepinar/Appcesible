import 'dart:io';

import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:appcesible/widgets/dialog_info.dart';
import 'package:flutter/material.dart';

import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/models/class_model.dart';

import 'package:appcesible/widgets/dialog_list_search.dart';
import 'package:appcesible/widgets/input_custom.dart';
import 'package:appcesible/widgets/input_dropdown.dart';
import 'package:appcesible/widgets/dialog_error.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:appcesible/widgets/upload_img.dart';
import 'package:appcesible/widgets/button.dart';

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
      home: FormularioUsuarios(title: 'Añadir usuario', newUser: true,),
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
  final int? id;
  final bool newUser;

  const FormularioUsuarios({
    super.key,
    required this.title,
    this.id,
    required this.newUser
  });

  @override
  FormularioAlumnosState createState() => FormularioAlumnosState();
}

class FormularioAlumnosState extends State<FormularioUsuarios> {
  late Function(UserModel, String, File) actionCall;
  UserModel user = UserModel(
    id: -1,
    userName: '',
    userType: -1,
    idClass: 0,
    loginType: 0,
    interactionFormat: -1
  );
  
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  
  List<UserModel> users = [];
  Map<String,bool> content = {'Texto':false,'Audio':false,'Imagenes':false};
  List<ClassModel> classes = [];
  List<String> userTypes = ['Profesor','Estudiante','Administrador'];
  Image _defaultImage = Image.asset('assets/images/addPicture.png');

  String _choosedTypes = '';
  String? _defaultTypeValue;
  String? _defaultClassValue;
  File? _pickedImage;

  bool userSelected=false;
  bool show=false;
  bool picto=false;

  bool _initialized = false;
  Future _initializeState() async {
    if (!_initialized) {
      actionCall = (widget.newUser && widget.id == null) ? createUser : updateUser;
      classes = await getClasses();

      if (!widget.newUser && widget.id != null) {
        userSelected = true;

        user = await getUserFromId(widget.id!);
        isUserStudent();

        _nameController.text = user.userName;

        _defaultTypeValue = _getDefaultTypeValue();
        _defaultClassValue = _getDefaultClassValue();
        _defaultImage = user.image!;
      }
      else if (!widget.newUser && widget.id == null) {
        users = await getAllUsers(true);
      }

      _initialized = true;
    }
  }

  Future _handleConfirm() async {
    await actionCall(user, _passwdController.value.text, _pickedImage!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose () {
    _userController.dispose();
    _nameController.dispose();
    _passwdController.dispose();

    super.dispose();
  }

  List<String> _getUsersNames() {
    List<String> usersNames = [];
    for (UserModel user in users) {
      usersNames.add(user.userName);
    }

    return usersNames;
  }

  int _getClassId(String name) {
    for (ClassModel classModel in classes) {
      if (classModel.className == name) {
        return classModel.id;
      }
    }

    return -1;
  }

  String? _getDefaultTypeValue() {
    return (user.userType != -1 && !widget.newUser && userSelected) ? userTypes[user.userType] : null;
  }

  String? _getDefaultClassValue() {
    return (!widget.newUser && userSelected && classes.any((classModel) => (classModel.id == user.idClass)))
      ? classes.firstWhere((classModel) => (classModel.id == user.idClass)).className
      : null;
  }

  void setContent() {
    content['Texto'] = (
      user.interactionFormat == 0 ||
      user.interactionFormat == 10 ||
      user.interactionFormat == 11 ||
      user.interactionFormat == 111
    );
    content['Audio'] = (
      user.interactionFormat == 1 ||
      user.interactionFormat == 10 ||
      user.interactionFormat == 12 ||
      user.interactionFormat == 111
    );
    content['Imagenes'] = (
      user.interactionFormat == 2 ||
      user.interactionFormat == 11 ||
      user.interactionFormat == 12 ||
      user.interactionFormat == 111
    );

    _choosedTypes = '';
  }

  void isUserStudent() async {
    if (user.userType == 1) {
      UserModel student = await getStudentFromId(user.id);

      setState(() {
        user = student;
        
        setContent();
        show = true;
        content.forEach((key, value) {
          if(value) _choosedTypes+=' $key ';
        });
      });
    }
    else {
      show = false;
    }
  }

  void showUsersPopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
          title: 'Usuario',
          label: 'Usuario',
          elements: _getUsersNames()
        );
      },
    );

    if (result != null) {
      setState(() {
        userSelected = true;
        
        user = users.firstWhere((element) => (element.userName == result),);
        isUserStudent();
        
        _userController.text = user.userName;
        _nameController.text = user.userName;
        
        _defaultTypeValue = _getDefaultTypeValue();
        _defaultClassValue = _getDefaultClassValue();
        _defaultImage = user.image!;
      });
    }
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
          child: Text('Seleccionados: $_choosedTypes'),
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

                _choosedTypes = '';
                content.forEach((key, value) {
                  if(value) {
                    _choosedTypes += ' $key ';
                  }
                });

                if (content['Texto'] ?? false) {
                  if (content['Audio'] ?? false) {
                    if (content['Picto'] ?? false) {
                      user.interactionFormat = 111;
                    }
                    else {
                      user.interactionFormat = 10;
                    }
                  }
                  else if (content['Picto'] ?? false) {
                    user.interactionFormat = 11;
                  }
                  else {
                    user.interactionFormat = 0;
                  }
                }
                else if (content['Audio'] ?? false) {
                  if (content['Picto'] ?? false) {
                    user.interactionFormat = 12;
                  }
                  else {
                    user.interactionFormat = 1;
                  }
                }
                else if (content['Picto'] ?? false) {
                  user.interactionFormat = 2;
                }
              });
            },
            elements: content.keys.toList(),
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeState(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: TopMenu(
            onHomeTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                    message: '¿Está seguro de que quiere abandonar el proceso?\nLos datos introducidos hasta el momento se perderán',
                    onConfirm: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return const TeacherHome();
                          }
                        ),
                        (route) => false
                      );
                    }
                  );
                }
              );
            }
          ),
          body: (_initialized || snapshot.connectionState == ConnectionState.done)
          ? SingleChildScrollView(
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
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  if (!widget.newUser && widget.id == null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FormEntry(
                        name: 'Seleccionar Usuario',
                        typeData: 4,
                        controller: _userController,
                        onTap: showUsersPopup,
                      ),
                    ),
                  Visibility(
                    visible: (widget.newUser || widget.id != null || userSelected),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Tipo de usuario',
                                  border: OutlineInputBorder(),
                                ),
                                value: _defaultTypeValue,
                                dropdownColor: Colors.white,
                                items: userTypes.map((element) {
                                  return DropdownMenuItem<String>(
                                    value: element,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(element),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    if (_defaultTypeValue != value) {
                                      _defaultTypeValue = value!;
                                      
                                      user.userType = userTypes.indexOf(value);
                                      show = (user.userType == 1);
                                    }
                                  });
                                },
                                isExpanded: true,
                              ),
                            ],
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
                        (user.userType != -1 && picto && userTypes[user.userType] == 'Estudiante')
                          ? passwdPic()
                          : passwdText(),
                        show ? Container(child: pictoCheckWid()):const SizedBox.shrink(),
                        show ? Container(child: contentW(context)):const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Clase',
                              border: OutlineInputBorder(),
                            ),
                            value: _defaultClassValue,
                            dropdownColor: Colors.white,
                            items: classes.map((element) {
                              return DropdownMenuItem<String>(
                                value: element.className,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(element.className),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                if (_defaultClassValue != value) {
                                  _defaultClassValue = value!;
                                  user.idClass = _getClassId(value);
                                }
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: IconButton(
                            iconSize: 20,
                            icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: _defaultImage.image,
                                    fit: BoxFit.fill
                                  )
                                ),
                                height: 192,
                                width: 192,
                                child: const ClipOval(),
                            ),
                            onPressed: () async {
                              _pickedImage = await UploadPicture.pickImage();

                              setState(() {
                                _defaultImage = Image.file(_pickedImage!);
                                user.image = _defaultImage;
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
                            onPressed: () async {
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
                              if (user.userType == -1) {
                                cont++;
                                msg = 'Rellene el campo tipo usuario';
                              }
                              if (user.userType != -1 && (user.interactionFormat == -1 && userTypes[user.userType]=='Estudiante')) {
                                cont++;
                                msg = 'Rellene el campo tipo de contenido';
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
                                setState(() {
                                  user.userName = _nameController.text;
                                });

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmationDialog(
                                      message: 'Los datos del usuario serán almacenados\n¿Quiere continuar?',
                                      onConfirm: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return FutureBuilder(
                                              future: _handleConfirm(),
                                              builder: (context, snapshot) {
                                                return (snapshot.connectionState == ConnectionState.done)
                                                  ? InfoDialog(
                                                    message: 'Los datos del usuario se han almacenado correctamente',
                                                    onPressed: () {
                                                      Navigator.of(context).pushAndRemoveUntil(
                                                          MaterialPageRoute(builder: (context) {
                                                        return const TeacherHome();
                                                      }), (route) => false);
                                                    },
                                                  )
                                                  : Scaffold(
                                                    appBar: TopMenu(
                                                      onHomeTap: () {},
                                                    ),
                                                    body: const LoadingDialog()
                                                  );
                                              }
                                            );
                                          },
                                          barrierDismissible: false,
                                        );
                                      }
                                    );
                                  }
                                );
                              }
                            },
                          ),
                        )
                      ]
                    ),
                  ),
                ],
              )
          )
          : const LoadingDialog(),
        );
      }
    );
  }
}
