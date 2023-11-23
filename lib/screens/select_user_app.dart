import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserApp extends StatefulWidget {
  SelectUserApp({Key? key});

  @override
  _SelectUserAppState createState() => _SelectUserAppState();
}

class _SelectUserAppState extends State<SelectUserApp> {
  List<String> imagenes = [
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopMenu(),
      body: Center(
        child: FittedBox(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 150,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.grey[500], // Cambia el color de fondo
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
              ),
              const SizedBox(height: 40),
              Column(children: [
                const SizedBox(
                  // Box where the name is shown
                  height: 50,
                  width: 250,
                  child: Center(
                    child: Text(
                      'Manolito',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 200,
                  width: 380,
                  child: Row(
                    children: <Widget>[
                      // Elevated Button to the previous user
                      ElevatedButton(
                        onPressed: currentIndex > 0
                            ? () {
                                setState(() {
                                  currentIndex = (currentIndex - 1)
                                      .clamp(0, imagenes.length - 1);
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
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
                      InkWell(
                        onTap: () {
                          // Maneja la acción al hacer clic en la imagen.
                          print('Imagen clickeada ${currentIndex}');
                          // Agrega el código que deseas ejecutar al hacer clic en la imagen.
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 5.0,
                            ),
                          ),
                          child: ClipOval(
                            child: _imageWidget(image: imagenes[currentIndex]),
                          ),
                        ),
                      ),

                      // Box transparent between the button and the profile picture
                      const SizedBox(width: 20),

                      // Elevated Button to the next user
                      ElevatedButton(
                        onPressed: currentIndex < imagenes.length - 1
                            ? () {
                                setState(() {
                                  currentIndex = (currentIndex + 1)
                                      .clamp(0, imagenes.length - 1);
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
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
                const SizedBox(height: 40),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageWidget({required String image}) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
