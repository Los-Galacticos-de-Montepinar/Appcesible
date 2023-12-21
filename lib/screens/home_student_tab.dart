import 'package:appcesible/screens/home_student.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_box_image_text.dart';
import 'package:appcesible/widgets/widget_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/widget_top_student.dart';
import 'package:appcesible/screens/student_diary.dart';

class HomeStudentTab extends StatefulWidget {
  const HomeStudentTab({super.key});

  @override
  State<StatefulWidget> createState() => _HomeStudentTabState();
}

class _HomeStudentTabState extends HomeStudentState<HomeStudentTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: TopMenuStudent(texto: 'INICIO', onHomeTap: () {},),
          body: (initialized || snapshot.connectionState == ConnectionState.done)
            ? Center(
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 15.0),
                    ImageWidget(image: profileImage),
                    const SizedBox(height: 10.0),
                    Text(
                      'Bienvenido, $userName',
                      style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    const Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                        ),
                        MyBoxWithImageAndText1(
                            text: 'AGENDA',
                            color: Colors.red,
                            color2: Color.fromARGB(255, 234, 151, 161),
                            destinationScreen: StudentDiary(),),
                        SizedBox(
                          width: 20.0,
                        ),
                        MyBoxWithImageAndText1(
                            text: 'HISTORIAL',
                            color: Colors.blue,
                            color2: Color.fromARGB(255, 130, 172, 192),
                            destinationScreen: HomeStudentTab(),),
                        SizedBox(
                          width: 20.0,
                        ),
                        MyBoxWithImageAndText1(
                            text: 'CHATS',
                            color: Colors.green,
                            color2: Color.fromARGB(255, 150, 216, 135),
                            destinationScreen: HomeStudentTab(),),
                        SizedBox(
                          width: 20.0,
                        ),
                        MyBoxWithImageAndText1(
                            text: 'AGENDA',
                            color: Colors.orange,
                            color2: Color.fromARGB(255, 222, 175, 90),
                            destinationScreen: HomeStudentTab(),),
                        SizedBox(
                          width: 20.0,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            )
            : const LoadingDialog(),
        );
      }
    );
  }
}
