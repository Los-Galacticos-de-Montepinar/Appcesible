import 'package:appcesible/command/session_command.dart';
import 'package:appcesible/models/gallery_model.dart';
import 'package:appcesible/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/insert_pass_pic_addUser_tab.dart';
import 'package:appcesible/screens/insert_pass_pic_addUser_mobile.dart';

class PassPictoNew extends StatelessWidget{
  const PassPictoNew({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const PassPictoNewApp();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const PassPictoNewTab();
      },
      desktop: (context) {
        ScreenUtilBreakpoints.initWebDesignSize(context);
        return const PassPictoNewTab();
      },
    );
  }
}

abstract class PassPictoNewState<T extends StatefulWidget> extends State<T> {
  Map<int,Image> imagenes = {};
  List<int> selectedImages = [];
  
  bool initialized = false;

  Future initializeState() async {
    if (!initialized) {
      await initSession(); // QUITAR CUANDO SE ACABE
      List<GalleryModel> aux = await getGallery();

      for(int i=0;i<aux.length;++i){
        imagenes[aux[i].id]=await downloadImage(aux[i].id);
      }

      initialized=true;
    }
  }

  Container mySecondGrid(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.grey,
      ),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        padding: const EdgeInsets.all(8),
        children: List.generate(selectedImages.length, (index) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: imagenes[index],
                ),
              ),
            );
        }),
      ),
    );
  }

  Container myFirstGrid() {
    List<IconButton> botonesImagenes=List.empty(growable: true); 

    imagenes.forEach((key,value) {
      botonesImagenes.add(
        IconButton(onPressed: (){selectedImages.add(key);}, icon: value)
      );
    });

    return Container(
      height: 400,
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.grey,
      ),
      child: Wrap(
        children: botonesImagenes,
      ),
    );
  }
}