import 'package:flutter/material.dart';

import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/screens/home_student.dart';
import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class Login extends StatefulWidget {
  final UserModel user;
  // final Image userImage;
  
  const Login({
    super.key,
    required this.user,
    // required this.userImage
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  bool _authenticationFailed = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopMenu(
        onHomeTap: () {}
      ),
      body: SingleChildScrollView(
        //margin: const EdgeInsets.only(left: 50, right: 50),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Image.asset(
                        'assets/images/back_arrow.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Contraseña',
                        //errorText: 'contraseña incorrecta',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 255),
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: visible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                        ),
                      ),
                      obscureText: visible,
                    ),
                    if (_authenticationFailed)
                      const Text(
                        'Contraseña incorrecta. Intentalo de nuevo',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 70),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    alignment: Alignment.center,
                    minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(134, 238, 238, 238)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        width: 1.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    bool correct = await authenticateUser(widget.user, password.text);
                    setState(() {
                      _authenticationFailed = !correct;
                    });

                    if (correct) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        if (widget.user.userType == 1) {
                          return const HomeStudentInit();
                        }
                        else {
                          return const TeacherHome();
                        }
                      }));
                    }
                  },
                  child: const Text(
                    'Iniciar Sesion',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}