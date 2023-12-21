import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/screens/pass_picto.dart';
import 'package:appcesible/screens/pass_text.dart';
import 'package:appcesible/screens/select_user.dart';
import 'package:flutter/material.dart';

class SelectMain extends StatelessWidget {
  const SelectMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool screenWidth = constraints.maxWidth > 600;

              return FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    if (screenWidth)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyBoxWithImageAndText(
                            text: 'ESTUDIANTES',
                            color: const Color.fromARGB(255, 0, 0, 0),
                            color2: const Color.fromARGB(255, 51, 159, 179),
                            destinationScreen: PictoPassw(),
                            size: 400,
                          ),
                          const SizedBox(width: 200.0),
                          MyBoxWithImageAndText(
                            text: 'Profesor',
                            color: const Color.fromARGB(255, 0, 0, 0),
                            color2: const Color.fromARGB(255, 119, 124, 119),
                            destinationScreen: PictoPassw(),
                            size: 250,
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          const MyBoxWithImageAndText(
                            text: 'ESTUDIANTES',
                            color: Color.fromARGB(255, 0, 0, 0),
                            color2: Color.fromARGB(255, 51, 159, 179),
                            destinationScreen: SelectUser(),
                            size: 300,
                          ),
                          const SizedBox(height: 60.0),
                          MyBoxWithImageAndText(
                            text: 'Profesor',
                            color: const Color.fromARGB(255, 0, 0, 0),
                            color2: const Color.fromARGB(255, 119, 124, 119),
                            destinationScreen: Login(
                              teacherInit: true,
                              user: UserModel(
                                id: -1,
                                userName: '',
                                userType: -1,
                                idClass: -1,
                                loginType: 1
                              ),
                            ),
                            size: 180,
                          ),
                        ],
                      ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

class MyBoxWithImageAndText extends StatelessWidget {
  final String text;
  final Color color;
  final Color color2;
  final Widget destinationScreen;
  final double size;

  const MyBoxWithImageAndText({
    super.key,
    required this.text,
    required this.color,
    required this.color2,
    required this.destinationScreen,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3.0),
          borderRadius: BorderRadius.circular(25.0),
          color: color2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            if (text != 'Profesor')
              Container(
                child: imageWidget(image: 'assets/images/alumnos.png'),
              ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 170,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectMain(),
    );
  }
}
