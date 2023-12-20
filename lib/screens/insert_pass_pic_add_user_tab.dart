import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/screens/insert_pass_pic_add_user.dart';
import 'package:appcesible/widgets/button.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';

class PassPictoNewTab extends StatefulWidget{
  const PassPictoNewTab({super.key});

  @override
  State<PassPictoNewTab> createState() => _PassPictoNewTabState();

}

class _PassPictoNewTabState extends PassPictoNewState<PassPictoNewTab> {
  Container mySecondGrid(Size screenSize){

    List <IconButton> aux=[];

    for(int i=0;i<selectedImages.length;++i){
      aux.add(
      IconButton(
              onPressed: (){
                selectedImages.removeAt(i);
                setState(() {});
              },
              icon: Image(image: imagenes[selectedImages[i]]!.image, height: screenSize.height*0.2, width: screenSize.width*0.2,)
      ));
    }

    return Container(
      width: screenSize.width,
      height: screenSize.height*0.2,
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
          title: const Text("¿Seguro que quieres guardar esta contraseña?"),
          actions: [
            SingleChildScrollView(
              child: Row(
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

  Container myFirstGrid(Size screenSize) {
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
                  Navigator.pop(context,selectedImages)
                }else if(value==false){
                  selectedImages=[],
                  setState((){})
                }
              });
            }
            }, 
          icon: Image(image: value.image,height: screenSize.height*0.3,width: screenSize.width*0.3),
          )
      );
    });

    return Container(
      height: screenSize.height*0.73,
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

    final Size screenSize=MediaQuery.of(context).size;

    return FutureBuilder(
      future: initializeState(),
      builder: (context, snapshot){
        return Scaffold(
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
            },
          ),
          body: (initialized || snapshot.connectionState == ConnectionState.done)
            ? SingleChildScrollView(
              child: Column(
                children: [
                  myFirstGrid(screenSize),
                  mySecondGrid(screenSize)
                ],
              ),
            )
            : const LoadingDialog()
        );
      },
    );
  }
}
