import 'package:flutter/material.dart';

class SelectUser extends StatelessWidget {
  const SelectUser({super.key});

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
                  'Manolito',
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
                    onPressed: () {},
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
                          'assets/images/alonso.png',
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
                    onPressed: () {},
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
