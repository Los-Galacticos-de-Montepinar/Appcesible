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
