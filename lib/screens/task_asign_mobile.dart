import 'package:flutter/material.dart';
import 'package:appcesible/widgets/top_menu.dart';

class TaskAsignMobile extends StatefulWidget{
  const TaskAsignMobile({super.key});

  @override
  TaskAsignMobileState createState() => TaskAsignMobileState();
}

class TaskAsignMobileState extends State<TaskAsignMobile>{
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: TopMenu(),
        body: Row(
          children: [
            Text("data")
          ],
        ),
      ),
    );
  }

}