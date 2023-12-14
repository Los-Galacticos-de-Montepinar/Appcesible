import 'package:appcesible/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:appcesible/screens/select_user_app.dart';
import 'package:appcesible/screens/select_user_tab.dart';
import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/screens/normal_passw.dart';
import 'package:appcesible/screens/pictograms_passw.dart';

class SelectUser extends StatelessWidget {
  const SelectUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const SelectUserApp();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const SelectUserTab();
      },
      desktop: (context) {
        ScreenUtilBreakpoints.initWebDesignSize(context);
        return const SelectUserTab();
      },
    );
  }
}

abstract class SelectionState<T extends StatefulWidget> extends State<T> {
  List<String> imagenes = [
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
  ];

  // List with the user id and the profile picture url
  int currentIndex = 0;
  List<MapEntry<UserModel, String>> profileList = [];

  Future<void> _initializeProfileList() async {
    profileList = await getInfoUsers() as List<MapEntry<UserModel, String>>;

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _initializeProfileList();

    super.initState();
  }

  void returnPage() {
    Navigator.pop(context);
  }

  void nextUser() {
    setState(() {
      currentIndex = (currentIndex + 1) % profileList.length;
    });
  }

  void previousUser() {
    setState(() {
      currentIndex = (currentIndex - 1) % profileList.length;
    });
  }

  void selectUser() {
    UserModel user = profileList[currentIndex].key;
    // Maneja la acción al hacer clic en la imagen.
    print('Usuario clickado, número: ${user.id}');

    if (user.userType == 1) {  // Falta la condición para modo de visualización
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
          return const PictoPassw();
        })
      );
    }
    else {
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
          return Login(user: user);
        })
      );
    }
  }
}