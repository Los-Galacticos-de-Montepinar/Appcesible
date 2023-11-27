import 'package:flutter/material.dart';
import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/widgets/alert_dialog.dart';
import 'package:appcesible/widgets/local_photo.dart';
import 'package:appcesible/models/user_model.dart';

/// Esto es una plantilla, para que sea la de añadir alumno, le pasais argumentos vacios, es decir, llamais al constructor
/// FormularioAlumnos("","","",{},[],,"")
/// si quereis editar,
/// FormularioAlumnos("Titulo","Nombre","Contraseña",{mapa con el tipo de contenido},[lista de clases],indice
/// de la clase a la que pertenece el alumnno,"enlace de la foto del alumno")
/// 
/// El mapa es basicamente, si tenemos como tipos de contenido audio, texto y pictogramas, y el alumno solo usa el texto,
/// su mapa será {"Audio":false,"Pictogramas":false,"Texto":true}, el índice es dentro de la lista que le pasamos,
/// la lista de clases es ["3A","2A","1A"] y el alumno esta en 2A, el indice que pasamos es 1

void main() {
  runApp( 
    const MaterialApp(
      home: FormularioUsuarios("Añadir alumno","","",{"Audio":false,"Pictogramas":false,"Texto":false},['1A','2A','3A'],-1,"",-1),
    ));
}

class FormularioUsuarios extends StatefulWidget {
  final String title;
  final String name;
  final String passwd;
  final Map<String,bool> content;
  final List<String> classes;
  final int classIndex;
  final String picture;
  final int userT;
  const FormularioUsuarios(this.title , this.name ,this.passwd, this.content , this.classes, this.classIndex, this.picture, this.userT ,{super.key});

  @override
  FormularioAlumnosState createState() => FormularioAlumnosState();
}

class FormularioAlumnosState extends State<FormularioUsuarios> {
  
  Map<String,bool> content = {};
  List<String> classes = [];
  int classIndex = -1;
  String choosedTypes = '';
  List<String> userTypes=[];
  int userT=-1;
  bool firstExe=true;
  bool show=false;
  bool picto=false;
  DecorationImage picture=const DecorationImage(image: AssetImage('assets/images/addPicture.png'), fit: BoxFit.fill);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  @override
  void dispose () {
    nameController.dispose();
    passwdController.dispose();

    super.dispose();
  }

  Widget passwdPic(){
    Image ejemplo=Image.asset("assets/images/addPicture.png");
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
        const Text("Contraseña con pictogramas")
      ],
    );
  }  

  Widget contentW(BuildContext context){
    return Column(
      children: [ Padding(
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
      )
    ;
  }

  @override
  Widget build(BuildContext context){
    final screenHeight = MediaQuery.of(context).size.height;

    const heightPercentage = 0.12;
    final heightTitle = screenHeight * heightPercentage;

    Function upload;
    if(firstExe){

      if(widget.name.isEmpty && widget.passwd.isEmpty){
        upload=createUser;
      }

      nameController = TextEditingController(text: widget.name);

      passwdController = TextEditingController(text: widget.passwd);

      content=Map.fromIterables(widget.content.keys, widget.content.values);

      classIndex=widget.classIndex;
      if(classIndex==-1){
        classes.add('');
        classes.addAll(widget.classes);
        classIndex=0;
        upload=createUser;
      }else{
        classes=widget.classes;
        upload=updateUser;
      }

      userT=widget.userT;
      if(userT==-1){
        userT=0;
        userTypes.add("");
      }
      userTypes.addAll(["Profesor","Estudiante","Administrador"]);

      show=userTypes[userT]=="Estudiante";

      content.forEach((key, value) {if(value) choosedTypes+=' $key ';});

      if(widget.picture!=""){
        //picture=DecorationImage(image: NetworkImage(widget.picture));
      }

      firstExe=false;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[300],
          title: const Text('AppCesible', textScaleFactor: 1.5),
          centerTitle: true,
          toolbarHeight: heightTitle,
        ),
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
                    )
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

                  Container(
                    height: 180,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        (!picto || userTypes[userT]!="Estudiante") ? passwdText():Container()
                        ,
                        (picto && userTypes[userT]=="Estudiante") ? passwdPic():Container()
                      ],
                    ),
                  ),

                  show ? Container(child: pictoCheckWid()):SizedBox.shrink()
                  ,
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField(
                      items: userTypes.map((e) => 
                        DropdownMenuItem(
                          value: e,
                          child: Text(e)
                        )
                      ).toList(),
                      onChanged: (value) => {
                        if (value != null && value!='') {
                          userT = userTypes.indexOf(value),
                          if(userTypes.contains('')){
                            userTypes.remove(''),
                            userT--,
                            setState(()=>{}),
                            },
                          if(userT==userTypes.indexOf("Estudiante"))
                            show=true
                          else
                            show=false
                          ,setState(() => {}),
                        }
                      },
                      value: userTypes[userT],
                      decoration: const InputDecoration(
                        labelText: 'Tipo de usuario'
                      ),
                    ),
                  ),
                  show ? Container(child: contentW(context)):SizedBox.shrink()
                  ,
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButtonFormField(
                      items: classes.map((e) => 
                        DropdownMenuItem(
                          value: e,
                          child: Text(e)
                        )
                      ).toList(),
                      onChanged: (value) => {
                        if (value != null && value!='') {
                          classIndex = classes.indexOf(value),
                          if(classes.contains('')){
                            classes.remove(''),
                            classIndex--,
                            setState(()=>{})
                            }
                        }
                      },
                      value: classes[classIndex],
                      decoration: const InputDecoration(
                        labelText: 'Clase'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: UploadPicture()                        
                    ),
                  Padding(
                  padding: const EdgeInsets.all(22),
                  child: TextButton(
                      onPressed: ()=>{
                        if(nameController.value.text.isEmpty)
                          dialogBuilder(context,"Rellene el campo nombre")
                        else if(passwdController.value.text.isEmpty)
                          dialogBuilder(context,"Rellene el campo contraseña")
                        else if(userTypes[userT]=="")
                          dialogBuilder(context,"Rellene el campo tipo usuario")
                        else if((choosedTypes.isEmpty && userTypes[userT]=="Estudiante"))
                          dialogBuilder(context,"Rellene el campo contenidos")
                        else if(classes[classIndex]=='')
                          dialogBuilder(context,"Rellene el campo clase")
                        else if((picture.image as AssetImage).assetName=='assets/images/addPicture.png')
                          dialogBuilder(context,"Rellene el campo foto")
                        else{
                          upload(
                            UserModel(id: id,
                                      userName: userName,
                                      idProfileImg: idProfileImg,
                                      userType: userType, 
                                      idClass: idClass, 
                                      age: age))
                        }
                      }, 
                      child: const Text("Finalizar")
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