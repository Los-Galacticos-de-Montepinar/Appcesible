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
  List<String> nombresUsuarios = [];
  int currentIndex = 0;

  Future<void> fetchDataFromServer() async {
    final response = await http.get(Uri.parse('http://172.17.0.1:8080/'));

    if (response.statusCode == 200) {
      // Procesa los datos recibidos desde el servidor
      final data = response.body;

      if (data.isNotEmpty) {
        final nombres = data.split(", ");
        setState(() {
          nombresUsuarios = nombres; // Asigna los nombres de usuario
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
    if (nombresUsuarios.isNotEmpty) {
      setState(() {
        currentIndex = (currentIndex + increment) % nombresUsuarios.length;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.grey[500],
              height: 80,
              width: 200,
              child: Center(
                child: Text(
                  nombresUsuarios.isNotEmpty
                      ? nombresUsuarios[currentIndex]
                      : "",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.yellow,
              height: 250,
              width: 350,
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // Cambiar al nombre anterior
                      changeUser(-1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      color: Colors.grey,
                      height: 200,
                      width: 50,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Cambiar al nombre siguiente
                      changeUser(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onPressedButton,
              child: Image.asset(
                'images/volver.png',
                height: 150,
                width: 240,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
