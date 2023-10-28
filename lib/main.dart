import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: MainApp(),
    ));

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Appcesible',
          style: TextStyle(
            fontSize: 40,
            //fontFamily: 'FontExample',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[500],
        toolbarHeight: 80,
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.black,
                height: 80,
                width: 200,
                child: const Center(
                  child: Text('nombreUsuario',
                      style: TextStyle(
                        fontSize: 25,
                        //fontFamily: 'FontExample',
                        color: Colors.white,
                      )),
                ),
              ),
              Container(
                color: Colors.yellow,
                height: 250,
                width: 350,
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: const Icon(Icons.arrow_back)),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: const Icon(Icons.arrow_forward))
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Seleccionar')),
            ],
          ),
        ),
      ),
    );
  }
}
