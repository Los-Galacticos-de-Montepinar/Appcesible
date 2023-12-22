import 'package:appcesible/screens/step_check_app.dart';
import 'package:appcesible/screens/step_check_tab.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:appcesible/screens/screenutil_init.dart';

class StepCheck extends StatelessWidget {
  final String image;
  final String texto;
  final Widget destinationScreen;

  const StepCheck({
    required this.image,
    required this.texto,
    required this.destinationScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return StepCheckMobile(
          image: image,
          texto: texto,
          destinationScreen: destinationScreen,
        );
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return StepCheckTablet(
          image: image,
          texto: texto,
          destinationScreen: destinationScreen,
        );
      },
    );
  }
}
