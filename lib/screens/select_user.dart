import 'package:appcesible/command/session_command.dart';
import 'package:flutter/material.dart';
import 'package:pair/pair.dart';
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
  // Image defaultImg = Image.file(file)
  List<Pair<GalleryModel, Image>> images = [];

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
      await initSession();

      profileList = await getAllUsers(true);

      List<GalleryModel> galleryList = await getGallery();
      for (GalleryModel image in galleryList) {
        if (_imageNeeded(image.id)) {
          Image img = await downloadImage(image.id);
          images.add(Pair(image, img));
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
    user.idProfileImg = images.firstWhere((pair) => (pair.key.id == user.idProfileImg)).key.id;

    // Maneja la acción al hacer clic en la imagen.
    print('Usuario clickado, número: ${profileList[index].id}');

    if (user.userType == 1) {
      // Falta la condición para modo de visualización
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return PictoPassw();
      }));
    } else {
      Image img = images.firstWhere((element) => (element.key.id == user.idProfileImg)).value;

      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        return Login(user: user, userImage: img,);
      }));
    }
  }

  Widget imageWidget(int id) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: images.firstWhere((element) => (element.key.id == profileList[id].idProfileImg)).value.image,
            fit: BoxFit.cover
          ),
        ),
    );
  }
}
