import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/insert_pass_pic_addUser_tab.dart';
import 'package:appcesible/screens/insert_pass_pic_addUser_mobile.dart';

class PassPictoNew extends StatelessWidget{
  const PassPictoNew({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return passPictoNewMobile();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return passPictoNewTab();
      },
    );
  }
}