import 'package:appcesible/screens/create_material_task_app.dart';
import 'package:appcesible/screens/create_material_task_tab.dart';
import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MaterialTask extends StatelessWidget {
  const MaterialTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const MaterialTaskApp();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const MaterialTaskTab();
      },
      desktop: (context) {
        ScreenUtilBreakpoints.initWebDesignSize(context);
        return const MaterialTaskTab();
      },
    );
  }
}
