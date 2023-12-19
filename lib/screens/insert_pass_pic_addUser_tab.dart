import 'package:appcesible/screens/insert_pass_pic_addUser_init.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';

class PassPictoNewTab extends StatefulWidget{
  const PassPictoNewTab({super.key});

  @override
  State<PassPictoNewTab> createState() => _PassPictoNewTabState();

}

class _PassPictoNewTabState extends PassPictoNewState<PassPictoNewTab> {
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
  
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: initializeState(),
      builder: (context, snapshot){
        return Scaffold(
          appBar: const TopMenu(),
          body: (initialized || snapshot.connectionState == ConnectionState.done)
            ? SingleChildScrollView(
              child: Column(
                children: [
                  myFirstGrid()
                ],
              ),
            )
            : const LoadingDialog()
        );
      },
    );
  }
}
