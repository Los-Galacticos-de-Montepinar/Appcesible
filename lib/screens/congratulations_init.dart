import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/congratulations_screen_app.dart';
import 'package:appcesible/screens/congratulations_screen_tablet.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CongratulationsInit extends StatelessWidget {
  const CongratulationsInit({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const CongratulationsScreenApp();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const CongratulationsScreenTablet();
      },
    );
  }
}

