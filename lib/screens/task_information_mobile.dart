import 'package:flutter/material.dart';
import 'package:appcesible/widgets/top_menu.dart';

class TaskInformationMobile extends StatelessWidget{
  const TaskInformationMobile ({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: TopMenu(),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }

}
