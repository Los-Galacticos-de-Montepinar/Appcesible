import 'package:flutter/material.dart';
import 'package:appcesible/widgets/top_menu.dart';

class TaskInformationTablet extends StatelessWidget{
  TaskInformationTablet ({super.key});

  final TextScaler titlesSize=TextScaler.linear(3);
  final TextScaler textSize=TextScaler.linear(2);

  /**
   * Container en el que guardo un texto para que se pegue a la izquierda del column
   */
  Padding textContainer(String text,TextScaler fontSize){
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
      alignment: Alignment.topLeft,
      child: Text(text,textAlign: TextAlign.left,textScaler: fontSize),
    )
    );
  }

  /**
   * Container de la derecha de la barra
   */
  Container bigContainer(BuildContext context, Size ScreenSize, bool delayed,String state ,String date, String hour, String delay){
    return Container(
      margin: EdgeInsets.all(12),
      width: ScreenSize.width*0.5,
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          textContainer("Detalles", titlesSize),
          textContainer("Estado - "+state,textSize),
          delayed ? textContainer("Fecha de Realizacion "+date,textSize):Container(),
          delayed ? textContainer("Hora de realizacion "+hour,textSize):Container(),
          !delayed ? textContainer("Retraso "+delay,textSize):Container()
        ],
      ),
    );
  }

  /**
   * La parte izquierda de la barra esta formada por un column que tiene 2 de estos
   */
  Container litlleContainer(BuildContext context, Size ScreenSize, String title, String text){
    return Container(
      height: ScreenSize.height*0.3,
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          textContainer(title,titlesSize),
          textContainer(text,textSize)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    var ScreenSize=MediaQuery.of(context).size;

    bool delayed=false;

    return MaterialApp(
      home: Scaffold(
        appBar: TopMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                /**
                 * Título gris de la ventana
                 */
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    border: Border.all(color: Colors.black)
                  ),
                  child: Text("Información Tarea",textScaler: TextScaler.linear(3)),
                ),
                /**
                 * Informacion de la tarea
                 */
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Container(
                    height: ScreenSize.height*0.7,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      /**
                       * Lo guardo en row todo de la forma
                       * Parte izquierda , barra negra del medio, parte derecha
                       */
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          /**
                           * Parte izquierda
                           */
                          Container(
                            width: ScreenSize.width*0.4,
                            child: SingleChildScrollView(
                              /**
                               * Column con los 2 container de la derecha
                               */
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    //------------ CAMBIAR NOMBRE ------------
                                    child: litlleContainer(context,ScreenSize,"Tarea","Nombre Tarea")
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    //------------ CAMBIAR NOMBRE ------------
                                    child: litlleContainer(context,ScreenSize,"Estudiante", "Nombre estudiante")
                                  ),
                                ],
                              ),
                            )
                          ),
                          /**
                           * Barra del medio
                           */
                          Container(
                            decoration: BoxDecoration(color: Colors.black),
                            width: ScreenSize.width*0.001,
                          ),
                          /**
                           * Parte de la derecha
                           */
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: bigContainer(context, ScreenSize ,delayed, "Completada","","","3 dias"),
                          )
                        ],
                      ),
                    )
                  ), 
                ),
                /**
                 * Boton de volver
                 */
                Padding(
                  padding: EdgeInsets.all(12),
                  child: FilledButton(
                    onPressed: (){}, 
                    child: Text("Volver",textScaler: titlesSize),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      minimumSize: Size(ScreenSize.width*0.6, ScreenSize.height*0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

}