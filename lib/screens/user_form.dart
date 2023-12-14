import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/widgets/alert_dialog_DEPRECATED.dart';
import 'package:appcesible/widgets/local_photo.dart';
import 'package:appcesible/models/user_model.dart';

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
    idProfileImg: -1,
    userType: 0,
    idClass: 0
  );
  
  TextEditingController nameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  
  Map<String,bool> content = {'Texto':false,'Audio':false,'Imagenes':false};
  final List<String> classes = ['','1A','2A','3A'];
  final List<String> userTypes = ['','Profesor','Estudiante','Administrador'];
  
  int classIndex = 0;
  String choosedTypes = '';

  //bool firstExe=true;
  bool show=false;
  bool picto=false;

  DecorationImage picture=const DecorationImage(
    image: AssetImage('assets/images/addPicture.png'),
    fit: BoxFit.fill
  );

  @override
  void initState() {
    super.initState();

    actionCall = (widget.id == -1) ? createUser : updateUser;

    if (widget.id!=-1) {
      user.id = widget.id;

      getUserFromId(user.id).then((value) {
        user = value;
        updateData(user.userName, {'Texto':false, 'Audio':false, 'Imagenes':false});
      })
      .catchError((e) { throw Exception(e); });
    }
  }
  
  void updateData(String uPass, Map<String, bool> contentType) {
    setState(() {
      nameController = TextEditingController(text: user.userName);
      passwdController = TextEditingController(text: uPass);      

      content = contentType;

      if (user.idClass!=-1 && classes.contains('')) {
        classes.remove('');
      }
      if(user.userType!=-1 && userTypes.contains('')) {
        userTypes.remove('');
      }

      show = userTypes[user.userType]=='Estudiante';
      content.forEach((key, value) {
        if(value) choosedTypes+=' $key ';
      });
    });
  }

  @override
  void dispose () {
    nameController.dispose();
    passwdController.dispose();

    super.dispose();
  }

  Widget passwdPic(){
    Image ejemplo=Image.asset('assets/images/addPicture.png');
    return ejemplo;
  }

  Widget passwdText(){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: passwdController,
        decoration: const InputDecoration(
          labelText: 'Contraseña',
          border: OutlineInputBorder(),
        ),
      )
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
          padding: const EdgeInsets.all(12),
          child: Text('Seleccionados: $choosedTypes'),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: DropdownButtonFormField(
            items: content.keys.map((e) => 
              DropdownMenuItem(
                value: e,
                child: Text(e)
              )
            ).toList(),
            onChanged: (value) => {
              if (value != null && content.containsKey(value))
                content[value] = !(content[value] ?? false)
              ,
              choosedTypes = ''
              ,
              content.forEach((key, value) {
                if(value) {
                  choosedTypes += ' $key ';
                }
              })
              ,
              setState(() {})
            },
            decoration: const InputDecoration(
              labelText: 'Tipo de contenido'
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    Image defaultImage=Image.asset('assets/images/addPicture.png');

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
                      textScaler: const TextScaler.linear(2.0),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField(
                      items: userTypes.map((e) => 
                        DropdownMenuItem(
                          value: e,
                          child: Text(e)
                        )
                      ).toList(),
                      onChanged: (value) {
                        if (value != null && value != '') {
                          user.userType = userTypes.indexOf(value);
                          if (userTypes.contains('')) {
                            userTypes.remove('');
                            user.userType--;
                          }

                          show = user.userType==userTypes.indexOf('Estudiante');
                          setState(() {});
                        }
                      },
                      value: userTypes[user.userType],
                      decoration: const InputDecoration(
                        labelText: 'Tipo de usuario'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre Completo',
                        border: OutlineInputBorder(),
                      ),
                    )
                  ),
                  (picto && userTypes[user.userType]=='Estudiante') ? passwdPic() : passwdText(),
                  show ? Container(child: pictoCheckWid()):const SizedBox.shrink(),
                  show ? Container(child: contentW(context)):const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField(
                      items: classes.map((e) => 
                        DropdownMenuItem(
                          value: e,
                          child: Text(e)
                        )
                      ).toList(),
                      onChanged: (value) {
                        if (value != null && value != '') {
                          classIndex = classes.indexOf(value);
                          if(classes.contains('')) {
                            classes.remove('');
                            classIndex--;
                          }

                          setState(() {});
                        }
                      },
                      value: classes[classIndex],
                      decoration: const InputDecoration(
                        labelText: 'Clase'
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(22),
                    child: UploadPicture()                        
                    ),
                  Padding(
                  padding: const EdgeInsets.all(22),
                  child: TextButton(
                      onPressed: () {
                        int cont = 0;
                        String msg = '';
                        if (nameController.value.text.isEmpty) {
                          cont++;
                          msg = 'Rellene el campo nombre';
                        }
                        if (passwdController.value.text.isEmpty) {
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
                        if (classes[classIndex]=='') {
                          cont++;
                          msg = 'Rellene el campo clase';
                        }
                        if (UploadPicture.of(context)!=null && defaultImage==UploadPicture.of(context)?.photo) {
                            cont++;
                            msg = 'Rellene el campo foto';
                        }
                        
                        if (cont > 0) {
                          if (cont > 1) msg = 'Faltan campos por rellenar';
                          dialogBuilder(context, msg);
                        }
                        else {
                          actionCall(user, passwdController.value.text);
                        }
                      }, 
                      child: const Text('Finalizar')
                    )
                  )
                ],
              )
          )
        ) 
      )
    );
  }
}