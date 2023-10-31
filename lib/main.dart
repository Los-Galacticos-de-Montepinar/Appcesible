import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(
      home: MainApp(),
    ));

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Map<String, String>> usersList = [];
  int currentIndex = 0;

  Future<void> fetchDataFromServer() async {
    final response = await http.get(Uri.parse('http://172.17.0.1:8080/'));

    if (response.statusCode == 200) {
      // Procesa los datos recibidos desde el servidor
      final data = response.body;

      if (data.isNotEmpty) {
        final users = data.split(", ");

        setState(() {
          int numUsers = users.length;
          String first = '', last = '';

          for (int i = 0; i < numUsers; i++) {
            final user = users.elementAt(i).split('=');
            first = user.first;
            last = user.last;
            Map<String, String> userMap = {};
            userMap['id'] = first;
            userMap['name'] = last;

            usersList.add(userMap);
          }
        });
      } else {
        // La respuesta está vacía
        print('La respuesta del servidor está vacía.');
      }
    } else {
      // Maneja errores de solicitud
      print('Error en la solicitud GET: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromServer(); // Realiza una solicitud GET al servidor
  }

  // Cambia usuario
  void changeUser(int increment) {
    if (usersList.isNotEmpty) {
      setState(() {
        currentIndex = (currentIndex + increment) % usersList.length;
      });
    }
  }

  // OnPressedButton
  void onPressedButton() {
    print('Volver al login principal...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Appcesible',
          style: TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[500],
        toolbarHeight: 80,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Padding for the back button
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 20.0,
                bottom: 30.0,
                right: 0.0,
              ),
              child: Align(
                  alignment: Alignment
                      .topLeft, // Alinea en la esquina superior izquierda
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.orange[600], // Cambia el color de fondo
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.subdirectory_arrow_left_outlined,
                              size: 38,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Volver',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  )),
            ),

            // User Content
            SizedBox(
              // Box where the name is shown
              height: 80,
              width: 250,
              child: Center(
                child: Text(
                  usersList.isNotEmpty
                      ? usersList[currentIndex].values.last
                      : "",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Container with the profile picture, and the button to
            // change the user
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              height: 200,
              width: 350,
              child: Row(
                children: <Widget>[
                  // Elevated Button to the previous user
                  ElevatedButton(
                    onPressed: () {
                      // Cambiar al nombre siguiente
                      changeUser(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          topRight: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 38, // Ajusta el tamaño según tus necesidades
                      color: Colors.white, // Cambia el color de la flecha
                    ),
                  ),

                  // Box transparent between the button and the profile picture
                  const SizedBox(width: 20),

                  // Profile Picture box
                  Expanded(
                    child: Container(
                      width: 200,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 5.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'images/alonso.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Box transparent between the button and the profile picture
                  const SizedBox(width: 20),

                  // Elevated Button to the next user
                  ElevatedButton(
                    onPressed: () {
                      // Cambiar al nombre siguiente
                      changeUser(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0.0),
                          bottomLeft: Radius.circular(0.0),
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 38, // Ajusta el tamaño según tus necesidades
                      color: Colors.white, // Cambia el color de la flecha
                    ),
                  ),
                ],
              ),
            ),

            // Button to select the profile shown
            SizedBox(
              width: 210,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[600],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle, // Ícono de flecha hacia adelante
                      size: 33,
                      color: Colors.white, // Color del ícono
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Seleccionar',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
