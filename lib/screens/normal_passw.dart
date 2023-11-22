import 'package:flutter/material.dart';

import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/widgets/top_menu.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopMenu(),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const TeacherHome();
                          }));
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
                        labelText: 'contraseña',
                        hintText: "contraseña",
                        //errorText: 'contraseña incorrecta',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 2,
                          ),
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
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                        ),
                      ),
                      obscureText: visible,
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
                  onPressed: () {},
                  child: const Text(
                    "Iniciar Sesion",
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
