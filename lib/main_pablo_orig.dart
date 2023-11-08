import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/models/user_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  Future<UserModel>? _user;

  @override
  void initState() {
    super.initState();

    _user = getUserFromId(2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<UserModel>(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Nombre de usuario: ${snapshot.data!.userName}');
              }
              else {
                return Text('${snapshot.error}');
              }
            },),
        ),
      ),
    );
  }
}
