import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserWeb extends StatefulWidget {
  SelectUserWeb({Key? key});

  @override
  _SelectUserWebState createState() => _SelectUserWebState();
}

class _SelectUserWebState extends State<SelectUserWeb> {
  List<String> imagenes = [
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/alonso.png',
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
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
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[500],
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 30.0,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.subdirectory_arrow_left_outlined,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Volver',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Box transparent between left and the button
                  const SizedBox(width: 40),

                  // Elevated Button to the previous user
                  ElevatedButton(
                    onPressed: currentIndex > 0
                        ? () {
                            setState(() {
                              currentIndex =
                                  (currentIndex - 6).clamp(0, imagenes.length);
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  // Box transparent between the button and the profile picture
                  const SizedBox(width: 50),
                  Container(
                    width: 1000,
                    height: 800,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 40.0,
                        crossAxisSpacing: 40.0,
                      ),
                      itemCount: currentIndex + 6 > imagenes.length
                          ? imagenes.length - currentIndex
                          : 6,
                      itemBuilder: (context, index) {
                        int imageIndex = currentIndex + index;
                        return InkWell(
                          onTap: () {
                            // Manejar el evento de clic aquí
                            print('Imagen clicada, número: $imageIndex');
                          },
                          child: Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 7.0,
                              ),
                            ),
                            child: ClipOval(
                              child: _imageWidget(image: imagenes[imageIndex]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Box transparent between the button and the profile picture
                  const SizedBox(width: 50),
                  // Elevated Button to the next user
                  ElevatedButton(
                    onPressed: currentIndex + 6 < imagenes.length
                        ? () {
                            setState(() {
                              currentIndex =
                                  (currentIndex + 6).clamp(0, imagenes.length);
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  // Box transparent between the button and right side
                  const SizedBox(width: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageWidget({required String image}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
