import 'package:flutter/material.dart';
import 'package:appcesible/widgets/top_menu.dart';

class TaskAsignTablet extends StatefulWidget{
  const TaskAsignTablet({super.key});

  @override
  taskAsignTabletState createState() => taskAsignTabletState();
}

class taskAsignTabletState extends State<TaskAsignTablet>{

  @override
  Widget build(BuildContext context){

    final Size screenSize=MediaQuery.of(context).size;
    final TextScaler titleSize=TextScaler.linear(2.5);
    final Color lightGrey=Colors.grey.shade300;
    final Color darkGrey=Colors.grey.shade400;
    final EdgeInsetsGeometry myPad12=EdgeInsets.all(12);
    final EdgeInsetsGeometry myPad8=EdgeInsets.all(12);

    TextEditingController alumnSearch=TextEditingController();

    Container searchResult(){
      return Container();
    }

    /**
     * Esta funcion se encarga de crear todas las funcionalidades de la barra de busqueda
     * de alumnos
     */
    Container searchBar(){
      return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              /**
               * Barra de texto para la busqueda
               */
              Container(
                margin: myPad8,
                height: screenSize.height*0.05,
                width: screenSize.width*0.3,
                child: TextField(controller: alumnSearch,decoration: InputDecoration(border: OutlineInputBorder())),  
              ),
              /**
               * Boton de filtros
               */
              IconButton(
                onPressed: (){},
                icon: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                  height: screenSize.height*0.05,
                  width: screenSize.width*0.05,
                  child: Image.asset("assets/images/filtrar.png"),
                )
              )
            ],
          ),
        ),
      );
    }

    Container elementBox(String text,Color myColor){
      return Container(
                width: screenSize.width*0.45,
                margin: myPad12,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: myColor
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(text,textScaler: titleSize,textAlign: TextAlign.center),
                ),
              );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: TopMenu(),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              /**
               * Parte izquierda
               */
              Container(
                width: screenSize.width*0.48,
                margin: myPad12,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /**
                       * Conatiner con la foto de la tarea y su nombre
                       */
                      Container(
                        height: screenSize.height*0.25,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // Foto
                              Padding(padding: EdgeInsets.all(20),child: Image.asset("assets/images/alonso.png",height: screenSize.height*0.2,)),
                              
                              // Nombre de la tarea
                              Container(
                                width: screenSize.width*0.3,
                                child: Text("Poner lavadora",textAlign: TextAlign.center,textScaler: titleSize),
                                decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
                              )
                            ],
                        ),
                        )
                      ),
                      /**
                       * Barra del medio
                       */
                      Container(
                        height: screenSize.height*0.001,
                        width: screenSize.width*0.45,
                        decoration: BoxDecoration(
                          color: Colors.black
                        ),
                      ),
                      /**
                       * Lista de alumnos asignados
                       */
                      SingleChildScrollView(
                        child: Container(
                          margin: myPad12,
                          height: screenSize.height*0.575,
                          width: screenSize.width*0.45,
                          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                          /**
                           * Lista de alumnos con la tarea asignada
                           */
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                elementBox("Sin asignar alumnos",lightGrey),

                              ],
                          ),
                          )
                        ),
                      )
                    ],
                ),
                )
              ),
              /**
               * Barra del medio
               */
              Container(
                height: screenSize.height*0.85,
                width: screenSize.width*0.001,
                decoration: BoxDecoration(color: Colors.black),
              ),
              /**
               * Parte derecha
               */
              Container(
                width: screenSize.width*0.48,
                margin: myPad12,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red)
                ),
                child: Column(
                  children: [
                    /**
                     * Titulo de la lista de alumnos
                     */
                    elementBox("Lista de alumnos",darkGrey),
                    /**
                     * Barra de busqueda
                     */
                    searchBar(),
                    /**
                     * Lista de alumnos encontrados
                     */
                    searchResult()
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

}