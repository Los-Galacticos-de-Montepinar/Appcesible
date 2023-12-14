import 'package:flutter/material.dart';

import 'package:appcesible/screens/select_user.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class SelectUserTab extends StatefulWidget {
  const SelectUserTab({super.key});

  @override
  State<SelectUserTab> createState() => _SelectUserTabState();
}

class _SelectUserTabState extends SelectionState<SelectUserTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopMenu(),
      body: Center(
        child: Container(
          width: 1024, // Ajusta según tus necesidades
          alignment: Alignment
              .topCenter, // Alinea el contenido en la parte superior del contenedor
          child: FittedBox(
            child: Column(
              children: [
                const SizedBox(height: 80),
                ElevatedButton(
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
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Box transparent between left and the button
                    const SizedBox(width: 10),

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
                        size: 38,
                        color: Colors.white,
                      ),
                    ),
                    // Box transparent between the button and the profile picture
                    const SizedBox(width: 20),
                    Container(
                      width: 900,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        itemCount: currentIndex + 6 > profileList.length
                            ? imagenes.length - currentIndex
                            : 6,
                        itemBuilder: (context, index) {
                          int imageIndex = currentIndex + index;
                          return InkWell(
                            onTap: () {
                              selectUser();
                            },
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    profileList.isNotEmpty ? profileList[currentIndex].key.userName : ' ',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
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
                                    child: _imageWidget(
                                        image: imagenes[imageIndex]),
                                  ),
                                ),
                              ],
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
                        size: 38,
                        color: Colors.white,
                      ),
                    ),
                    // Box transparent between the button and right side
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
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