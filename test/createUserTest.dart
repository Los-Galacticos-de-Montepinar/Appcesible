import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appcesible/screens/create_user.dart';
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
  final int userT=1;//Random().nextInt(3);

  Map<String,bool> content = {'Texto':false,'Audio':false,'Imagenes':false};
  List<int> elecciones=List.empty(growable: true);

  final int clase=Random().nextInt(3);

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

    //expect(find.byKey(ctK), findsOne);
    expect(find.byKey(utK), findsOne);
    expect(find.byKey(nK), findsOne);
    expect(find.byKey(ptK), findsOne);
    //expect(find.byKey(ppK), findsOne);
    expect(find.byKey(cK), findsOne);

    /**
     * Tipo de usuario y clase seleccionada
     */
    final List<String> classes = ['1A','2A','3A'];

    /**
   * Vamos a intentar simular que el cliente selecciona varias cosas y deselecciona
   */

    await tester.tap(find.byKey(utK));
    await tester.pump();
    await tester.tap(find.text(userTypes[userT]));
    await tester.pump();

    /**
     * Nombres y contraseñas de distintos valores y longitudes
     */
    
    //Metemos el nombre
    await tester.enterText(find.byKey(nK), name);
    await tester.pump();

    expect(find.text(name), findsOne);

    //AHora solo comprobamos que se despliegue la ventana, cuando se termine de impkementar habrá que hacer más cosas
    if(userTypes[userT]=='Estudiante'){
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      expect(find.byKey(ppK),findsOne);
      //Quitamos la imagen de ejemplo
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
    }

    //Metemos contraseña
    await tester.enterText(find.byKey(ptK), passwd);
    await tester.pump();

    expect(find.text(passwd), findsOne);

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
  });

}