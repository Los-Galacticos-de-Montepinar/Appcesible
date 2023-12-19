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
}