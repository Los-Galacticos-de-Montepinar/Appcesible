import 'package:appcesible/widgets/widget_top_initial.dart';
import 'package:flutter/material.dart';

import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/screens/home_student.dart';
import 'package:appcesible/screens/home_teacher.dart';

class Login extends StatefulWidget {
  final UserModel user;
  final Image userImage;
  
  const Login({
    super.key,
    required this.user,
    required this.userImage
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
      backgroundColor: Colors.white,
      appBar: const TopBarInitial(showArrow: true),
      body: Center(
        child: Container(
          width: 1024,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
                child: ClipOval(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: widget.userImage.image,
                          fit: BoxFit.cover
                        ),
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0,),
              Column(
                children: [
                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(color: Colors.black),
                      hintText: 'Contraseña',
                      //errorText: 'contraseña incorrecta',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black,
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
                    Text(
                      'Contraseña incorrecta. Intentalo de nuevo',
                      style: TextStyle(color: const Color(0xFFBF1717).withOpacity(0.8)),
                    ),
                ],
              ),
              const SizedBox(height: 40.0,),
              ElevatedButton(
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
                  NavigatorState navigator = Navigator.of(context);

                  bool correct = await authenticateUser(widget.user, password.text);
                  setState(() {
                    _authenticationFailed = !correct;
                  });

                  if (correct) {
                    navigator.push(MaterialPageRoute(builder: (context) {
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
            ],
          ),
        ),
      ),
    );
  }
}