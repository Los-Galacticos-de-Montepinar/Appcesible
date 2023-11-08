import 'package:appcesible/screens/screen_util_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/select_user_app.dart';
import 'package:appcesible/widgets/select_user_tab.dart';
import 'package:appcesible/widgets/select_user_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
        return const SelectUserWeb();
      },
    );
  }
}
