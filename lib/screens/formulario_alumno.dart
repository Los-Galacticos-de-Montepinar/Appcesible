import 'package:flutter/material.dart';
import 'package:appcesible/services/user_service.dart';

class FormularioAlumnos extends StatefulWidget {
  final String title;
  final String name;
  final String passwd;
  final Map<String,bool> content;
  final List<String> classes;
  final int classIndex;
  final String picture;
  final int userT;
  const FormularioAlumnos(this.title , this.name ,this.passwd, this.content , this.classes, this.classIndex, this.picture, this.userT ,{super.key});

  @override
  FormularioAlumnosState createState() => FormularioAlumnosState();
}

class FormularioAlumnosState extends State<FormularioAlumnos> {
  Map<String,bool> content = {};
  List<String> classes = [];
  int classIndex = -1;
  String choosedTypes = '';
  List<String> userTypes=[];
  int userT=-1;
  bool firstExe=true;
  bool show=false;
  DecorationImage picture=const DecorationImage(image: AssetImage('assets/images/addPicture.png'), fit: BoxFit.fill);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  @override
  void dispose () {
    nameController.dispose();
    passwdController.dispose();

    super.dispose();
  }

  void _showAlertDialog(String text) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: const Text("Alerta"),
          content: Text(text),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("CERRAR", style: TextStyle(color: Colors.white),),
              onPressed: (){ Navigator.of(context).pop(); },
            )
          ],
        );
      }
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
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: passwdController,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
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
                    child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: picture
                          ),
                          height: 128,
                          width: 128,
                          child: const ClipOval(),
                        ),
                        
                    ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () => {}, 
                        child: const Text("Subir Foto")
                      ),
                        ),
                  Padding(
                  padding: const EdgeInsets.all(22),
                  child: TextButton(
                      onPressed: ()=>{
                        if(nameController.value.text.isEmpty)
                          _showAlertDialog("Rellene el campo nombre")
                        else if(passwdController.value.text.isEmpty)
                          _showAlertDialog("Rellene el campo contraseña")
                        else if(choosedTypes.isEmpty)
                          _showAlertDialog("Rellene el campo contenidos")
                        else if(classes[classIndex]=='')
                          _showAlertDialog("Rellene el campo clase")
                        else if((picture.image as AssetImage).assetName=='assets/images/addPicture.png')
                          _showAlertDialog("Rellene el campo foto")
                        //else
                          //upload()
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