import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:appcesible/services/media_service.dart';
import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/models/gallery_model.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/select_user_app.dart';
import 'package:appcesible/screens/select_user_tab.dart';
import 'package:appcesible/screens/pass_text.dart';
import 'package:appcesible/screens/pass_picto.dart';

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
  // List with the user id and the profile picture url
  int currentIndex = 0;
  List<UserModel> profileList = [];
  List<Image> images = [];

  bool initialized = false;

  bool _imageNeeded(int id) {
    for (UserModel user in profileList) {
      if (user.idProfileImg == id) {
        return true;
      }
    }

    return false;
  }

  Future initializeProfileList() async {
    if (!initialized) {
      profileList = await getAllUsers();
      print(profileList);

      List<GalleryModel> galleryList = await getGallery();
      print(galleryList);
      for (GalleryModel image in galleryList) {
        print(image.id);
        if (_imageNeeded(image.id)) {
          Image img = await downloadImage(image.id);
          print(img);
          images.add(img);
        }
      }

      initialized = true;
    }
  }

  @override
  void initState() {
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

  void selectUser(int index) {
    UserModel user = profileList[index];
    // Maneja la acción al hacer clic en la imagen.
    print('Usuario clickado, número: ${profileList[index].id}');

    if (user.userType == 1) {
      // Falta la condición para modo de visualización
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return PictoPassw();
      }));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return Login(user: user);
      }));
    }
  }

  Widget imageWidget(int id) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: images[id].image, fit: BoxFit.cover)
        ),
    );
  }
}
