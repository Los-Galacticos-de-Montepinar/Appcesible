import 'package:appcesible/screens/insert_pass_pic_addUser_init.dart';
import 'package:appcesible/widgets/button.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';

class PassPictoNewApp extends StatefulWidget{
  const PassPictoNewApp({super.key});

  @override
  State<PassPictoNewApp> createState() => PassPictoNewAppState();

}

class PassPictoNewAppState extends PassPictoNewState<PassPictoNewApp> {
  Container mySecondGrid(Size ScreenSize){

    List <IconButton> aux=[];

    for(int i=0;i<selectedImages.length;++i){
      aux.add(
      IconButton(
              onPressed: (){
                selectedImages.removeAt(i);
                setState(() {});
                print(selectedImages);
              },
              icon: Image(image: imagenes[selectedImages[i]]!.image, height: ScreenSize.height*0.2, width: ScreenSize.width*0.2,)
      ));
    }

    return Container(
      width: ScreenSize.width,
      height: ScreenSize.height*0.2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.grey,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: aux,
        ),
      )
    );
  }

  Future<bool?> confirmationDialog(BuildContext context) async{
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text("¿Seguro que quieres guardar esta contraseña?",textScaler: TextScaler.linear(0.6),),
          actions: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ActionButton(
                  text: 'No',
                  type: 0,
                  onPressed: () {
                    Navigator.pop(context, false);
                  }
                  ),
                  const SizedBox(width: 8.0,),
                  ActionButton(
                    text: 'Sí',
                    type: 1,
                    onPressed: () {
                      Navigator.pop(context, true);
                    }
                  ),
                ],
            ),
            )
          ],
        );
      }
    );
  }

  Container myFirstGrid(Size ScreenSize) {
    List<IconButton> botonesImagenes=List.empty(growable: true); 

    imagenes.forEach((key,value) {
      botonesImagenes.add(
        IconButton(
          onPressed: (){
            selectedImages.add(key);
            setState(() {});
            if(selectedImages.length==3){
              confirmationDialog(context).then((value) => {
                if(value!=null && value){
                  //Subir al server
                  Navigator.pop(context,selectedImages)
                }else if(value==false){
                  selectedImages=[],
                  setState((){})
                }
              });
            }
            }, 
          icon: Image(image: value.image,height: ScreenSize.height*0.3,width: ScreenSize.width*0.3),
          )
      );
    });

    return Container(
      height: ScreenSize.height*0.73,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.white,
      ),
      child: Wrap(
        children: botonesImagenes,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context){

    final Size ScreenSize=MediaQuery.of(context).size;

    return FutureBuilder(
      future: initializeState(),
      builder: (context, snapshot){
        return Scaffold(
          appBar: TopMenu(
            onHomeTap: () {

            },
          ),
          body: (initialized || snapshot.connectionState == ConnectionState.done)
            ? SingleChildScrollView(
              child: Column(
                children: [
                  myFirstGrid(ScreenSize),
                  mySecondGrid(ScreenSize)
                ],
              ),
            )
            : const LoadingDialog()
        );
      },
    );
  }
}
