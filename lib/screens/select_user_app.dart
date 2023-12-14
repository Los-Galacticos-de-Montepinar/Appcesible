import 'package:flutter/material.dart';

import 'package:appcesible/screens/select_user.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class SelectUserApp extends StatefulWidget {
  const SelectUserApp({super.key});

  @override
  State<SelectUserApp> createState() => _SelectUserAppState();
}

class _SelectUserAppState extends SelectionState<SelectUserApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopMenu(),
      body: Center(
        child: Container(
          width: 1024, // Ajusta según tus necesidades
          alignment: Alignment.topCenter, // Alinea el contenido en la parte superior del contenedor
          child: FittedBox(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 80),
                SizedBox(
                  width: 160,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        returnPage();
                      },
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
                const SizedBox(height: 65),
                Column(children: [
                  SizedBox(
                    // Box where the name is shown
                    height: 50,
                    width: 250,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          profileList.isNotEmpty ? profileList[currentIndex].key.userName : ' ',
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 200,
                    width: 412,
                    child: Row(
                      children: <Widget>[
                        // Elevated Button to the previous user
                        ElevatedButton(
                          onPressed: () {
                            previousUser();
                          },
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
                            selectUser();
                          },
                          child: Container(
                            width: 200,
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
                          onPressed: () {
                            nextUser();
                          },
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
      )
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
