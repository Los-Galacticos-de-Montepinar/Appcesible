import 'package:appcesible/services/media_service.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/models/gallery_model.dart';
import 'package:appcesible/services/user_service.dart';

class passPictoNewTab extends StatefulWidget{

  passPictoNewTab({Key? key}) : super(key: key);

  @override
  passPictoNewTabState createState() => passPictoNewTabState();

}

class passPictoNewTabState extends State<passPictoNewTab>{

  Map<int,Image> imagenes=Map();
  bool _initialized=false;
  List<int> selectedImages=[];

  Future _initializeState() async{
    if(!_initialized){
      List<GalleryModel> aux=List.empty(growable: true);

      getGallery().then((value) => aux=value);

      for(int i=0;i<aux.length;++i){
        imagenes[aux[i].id]=await downloadImage(aux[i].id);
      }

      _initialized=true;
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

  Container myFirstGrid(){

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

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _initializeState(),
      builder: (content,snapshot){
        return Scaffold(
          appBar: TopMenu(),
          body: (_initialized || snapshot.connectionState == ConnectionState.done) ?
            SingleChildScrollView(
              child: Column(
                children: [
                  myFirstGrid()
                ],
              ),
            ):const LoadingDialog()
        );
      },
    );
  }
}