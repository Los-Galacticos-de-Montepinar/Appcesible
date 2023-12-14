import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/seleccionar_estudiante_window.dart';

class TaskAsignTablet extends StatefulWidget{
  const TaskAsignTablet({super.key});

  @override
  taskAsignTabletState createState() => taskAsignTabletState();
}

class taskAsignTabletState extends State<TaskAsignTablet>{

    final TextScaler titleSize=TextScaler.linear(2.5);
    final Color lightGrey=Colors.grey.shade300;
    final Color darkGrey=Colors.grey.shade400;
    final EdgeInsetsGeometry myPad12=EdgeInsets.all(12);
    final EdgeInsetsGeometry myPad8=EdgeInsets.all(12);

    //Para controlar la barra de busqueda de alumnos
    TextEditingController alumnSearch=TextEditingController();
    //Aqui guardo los alumnos seleccionados para la tarea
    Map<int,String> selected=Map();
    //Aqui voy a guardar las clases, que las tengo qwe descargar de la BD,
    //las usare para hacer los filtros por clase
    List<String> classList=List.empty(growable: true);
    
    @override
    void initState(){
      super.initState();

      //classList=funcion de peticion para descargar las clases

      classList.add("3A");
      classList.add("2A");
      classList.add("1A");
    }

    /**
     * Construye el container de la caja cuadrada gris
     */
    Container elementBox(Size screenSize,String text,Color myColor, EdgeInsetsGeometry pad){
      return Container(
                width: screenSize.width*0.45,
                margin: pad,
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

     /**
       * Container de los alumnos en la busqueda
       */
     Container searchResult(Size screenSize){
      return Container(
        margin: myPad12,
        height: screenSize.height*0.55,
        decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
        child: buttonStudents(screenSize,alumnBDpetition(""))
      );
    }

    /**
     * Esta funcion descarga a los alumnos de la DB y devuelve un map con nombre e id
     */
    Map<int,String> alumnBDpetition(String name){
      Map<int,String> res=Map();

      /**
       * INSERTAR FUNCION PARA LA PETICION DE LA BD
       */
      res[1]="manolo";
      res[2]="aaaaaa";
      res[3]="juan";
      //Los nombres son para debugar

      return res;
    }

    /**
     * Crea un column con los alumnos que se le pasa por argimento, la lista cre botones con sus nombres
     */
    Column buttonStudents(Size screenSize,Map<int,String> students){

      List<IconButton> studentsContainersButtons=List.empty(growable: true);
      students.forEach((Key,value){
        studentsContainersButtons.add(
          IconButton(
            onPressed: (){
              if(selected.containsKey(Key)){
                selected.removeWhere((key2, value2) => key2==Key);
              }else{
                selected[Key]=value;
              }
              setState(() {});
            }, 
            icon: elementBox(screenSize, value, lightGrey, myPad8)
            )
        );
      });

      return Column(children: studentsContainersButtons);
    }

  @override
  Widget build(BuildContext context){

    final Size screenSize=MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: TopMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Row(
                children: [
                  /**
                   * Parte izquierda
                   */
                  Container(
                    width: screenSize.width*0.48,
                    margin: myPad12,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /**
                           * Conatiner con la foto de la tarea y su nombre
                           */
                          Container(
                            height: screenSize.height*0.22,
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
                                  )
                                ],
                            ),
                            )
                          ),
                          /**
                           * Barra del medio horizontal
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
                                child: buttonStudents(screenSize,selected)
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
                    height: screenSize.height*0.82,
                    width: screenSize.width*0.001,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  /**
                   * Parte derecha
                   */
                  Container(
                    width: screenSize.width*0.48,
                    margin: myPad12,
                    child: Column(
                      children: [
                        /**
                         * Titulo de la lista de alumnos
                         */
                        elementBox(screenSize,"Lista de alumnos",darkGrey,myPad12),
                        /**
                         * Lista de alumnos encontrados
                         */
                        //searchResult(screenSize)
                        SeleccionarEstudianteWindow()
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
                  minimumSize: Size(screenSize.width*0.6, screenSize.height*0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)
                  )
                ),
                onPressed: (){
                  /**
                   * INSERTAR FUNCION PARA SUBIR LOS ASIGNADOS DE LA TAREA EN LA BD
                   */
                }, 
                child: Text("Confirmar")
              ),
             )
            ],
          ),
        )
      ),
    );
  }

}