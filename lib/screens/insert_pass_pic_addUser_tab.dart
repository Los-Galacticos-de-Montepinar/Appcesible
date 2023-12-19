import 'package:appcesible/screens/insert_pass_pic_addUser_init.dart';
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

  Container myFirstGrid(Size ScreenSize) {
    List<IconButton> botonesImagenes=List.empty(growable: true); 

    imagenes.forEach((key,value) {
      botonesImagenes.add(
        IconButton(
          onPressed: (){
            selectedImages.add(key);
            setState(() {});
            if(selectedImages.length==3){
              ConfirmationDialog(message: "Seguro que quieres esta contraseña", onConfirm: (){});
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
          appBar: const TopMenu(),
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
