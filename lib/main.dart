import 'package:appcesible/screens/select_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:appcesible/screens/insert_pass_pic_addUser_init.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'), // English
      Locale('es', 'ES'), // Spanish
    ],
    home: ScreenUtilInit(
      builder: (context, child) {
        return const MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('es', 'ES'), // Spanish
          ],
          home: HomeStudentInit(),
        );
      },
    ),
  ));
}

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   // SELECCION DE USUARIO
  
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(412, 570), // ?
//       builder: (context, child) {
//         return const MaterialApp(
//           home: SelectUser(),
//         );
//       },
//     );
//   }
// }
