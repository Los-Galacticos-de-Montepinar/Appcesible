import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserTab extends StatefulWidget {
  SelectUserTab({Key? key});

  @override
  _SelectUserTabState createState() => _SelectUserTabState();
}

class _SelectUserTabState extends State<SelectUserTab> {
  List<String> imagenes = [
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
    'assets/images/ronaldo.png',
    'assets/images/ronaldo.png',
    'assets/images/ronaldo.png',
    'assets/images/ronaldo.png',
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Box transparent between left and the button
                  const SizedBox(width: 10),

                  // Elevated Button to the previous user
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex =
                            (currentIndex - 6).clamp(0, imagenes.length - 1);
                      });
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
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                  // Box transparent between the button and the profile picture
                  const SizedBox(width: 20),
                  Container(
                    width: 600,
                    height: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: (currentIndex + 6).clamp(0, imagenes.length),
                      itemBuilder: (context, index) {
                        return FittedBox(
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
                              child: _imageWidget(image: imagenes[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Box transparent between the button and the profile picture
                  const SizedBox(width: 20),
                  // Elevated Button to the next user
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentIndex =
                            (currentIndex + 6).clamp(0, imagenes.length - 1);
                      });
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
                      size: 38,
                      color: Colors.white,
                    ),
                  ),
                  // Box transparent between left and the button
                  const SizedBox(width: 10),
                ],
              ),
              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageWidget({required String image}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
