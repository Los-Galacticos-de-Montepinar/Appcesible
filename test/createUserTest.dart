import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'codes/create_user_tester.dart';
import 'dart:math';
import 'package:random_string/random_string.dart';

/**
 * Esta funcion sirve para comprobar el verdadero resultado de las elecciones que hemos imulado
 * en el contenType del alumno
 */
Map<String,bool> resultadoContentType(Map<String,bool> myMap, List<int> elecciones){
  
  var res=myMap;
  final seleccionables=myMap.keys.toList();

  for(int i=0;i<elecciones.length;++i){
    res[seleccionables[elecciones[i]]]=(res[seleccionables[elecciones[i]]])!;
  }

  return res;
}

void main(){

  /**
   * Guardo las elecciones hechas en la simulacion para testearlas en la funcTest
   */
  final nameLenght=Random().nextInt(14)+1;
  final name=randomString(nameLenght);

  final passLenght=Random().nextInt(14)+1;
  final passwd=randomString(passLenght);

  final List<String> userTypes = ['Profesor','Estudiante','Administrador'];
  final int userT=Random().nextInt(3);

  Map<String,bool> content = {'Texto':false,'Audio':false,'Imagenes':false};
  List<int> elecciones=List.empty(growable: true);

  final List<String> classes = ['1A','2A'];
  final int clase=Random().nextInt(classes.length);

  final resultadoContentT=resultadoContentType(content, elecciones);

  

  testWidgets('Widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FormularioUsuarios(title: "Añadir usuarios",newUser: true));

    const ctK=Key("contentType");
    const utK=Key("userType");
    const nK=Key("name");
    const ptK=Key("passwdT");
    const ppK=Key("passwdP");
    const cK=Key("class");

    //print("--------- Encontrar widgets ---------\n");

    expect(find.byKey(utK), findsOne);
    //print("Widget tipo de usuario encontrado");
    expect(find.byKey(nK), findsOne);
    //print("Widget insertar nombre encontrado");
    expect(find.byKey(ptK), findsOne);
    //print("Widget contraseña de texto encontrado");
    expect(find.byKey(cK), findsOne);
    //print("Widget seleccion de clase encontrado\n");

    //print("-------------------------------------\n");
    /**
     * Tipo de usuario y clase seleccionada
     */

    /**
   * Vamos a intentar simular que el cliente selecciona varias cosas y deselecciona
   */


    //print("--------- Insertar datos ---------\n");
    await tester.tap(find.byKey(utK));
    await tester.pump();
    await tester.tap(find.text(userTypes[userT]));
    await tester.pump();

    //print("El tipo de usuario se inserta correctamente "+userTypes[userT].toString());
    /**
     * Nombres y contraseñas de distintos valores y longitudes
     */
    
    //Metemos el nombre
    await tester.enterText(find.byKey(nK), name);
    await tester.pump();

    expect(find.text(name), findsOne);

    //print("Nombre insertado correctamente: "+name);
    //AHora solo comprobamos que se despliegue la ventana, cuando se termine de impkementar habrá que hacer más cosas
    if(userTypes[userT]=='Estudiante'){

      //print("----- Pruebas para especiales usuario estudiante -----\n");
      expect(find.byKey(ctK), findsOne);
      //print("Encontrado el checkBox para contraseña por pictogramas");

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(find.byKey(ppK),findsExactly(2));
      //print("Encontrado el boton para la insertar contraseña por pictogramas");
      //Quitamos la imagen de ejemplo
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(find.byKey(ppK),findsOne);
      //print("Se ha escondido el boton para la insertar contraseña por pictogramas correctamente\n");

      //print("------- Fin de pruebas especiales --------");
    }

    //Metemos contraseña
    await tester.enterText(find.byKey(ptK), passwd);
    await tester.pump();

    expect(find.text(passwd), findsOne);
    //print("La contraseña se ha introducido correctamente: "+passwd);

    if(userTypes[userT]=='Estudiante'){
      //El numero de elecciones que ha hecho el usuario
      final int nElecciones=Random().nextInt(20);

      //Las eleciones que ha hecho
      for(int i=0;i<nElecciones;++i){
        elecciones.add(Random().nextInt(3));
      }

      //Los posibles elementos seleccionados
      final listaContenido=content.keys.toList();

      //Vamos seleccionando
      for(int i=0;i<nElecciones;++i){
        await tester.tap(find.byKey(ctK));
        await tester.pump();
        await tester.tap(find.text(listaContenido[elecciones[i]]).last);
        await tester.pump();
      }      

      //Comprobamos que se muestren por pantalla dichas elecciones
      resultadoContentT.forEach((key, value) {
        if(value)
          //Encuentra 2 porque esta el itemMenu y el del display
          expect(find.text(key), findsExactly(2));
      });
    }

    

    /**
     * Seleccion de clase
     */

    await tester.tap(find.byKey(cK));
    //Nos aseguramos de que se despliegue el menu
    await tester.pump();

    //Seleccionamos la clase
    await tester.tap(find.text(classes[clase]));
    await tester.pump();

    expect(find.text(classes[clase]), findsOne);
    //print("La clase se ha seleccionado correctamente: "+classes[clase]);
  });

}