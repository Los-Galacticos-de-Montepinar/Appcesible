import 'package:appcesible/screens/insert_pass_pic_addUser_init.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';

class PassPictoNewApp extends StatefulWidget{
  const PassPictoNewApp({super.key});

  @override
  State<PassPictoNewApp> createState() => _PassPictoNewAppState();

}

class _PassPictoNewAppState extends PassPictoNewState<PassPictoNewApp> {
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: initializeState(),
      builder: (context, snapshot){
        return Scaffold(
          appBar: const TopMenu(),
          body: (initialized || snapshot.connectionState == ConnectionState.done)
            ? SingleChildScrollView(
            )
            : const LoadingDialog()
        );
      },
    );
  }
}
