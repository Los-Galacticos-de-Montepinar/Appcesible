import 'package:appcesible/widgets/widget_top_initial.dart';
import 'package:flutter/material.dart';

import 'package:appcesible/screens/select_user.dart';
import 'package:appcesible/widgets/dialog_loading.dart';

class SelectUserApp extends StatefulWidget {
  const SelectUserApp({super.key});

  @override
  State<SelectUserApp> createState() => _SelectUserAppState();
}

class _SelectUserAppState extends SelectionState<SelectUserApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeProfileList(),
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: const TopBarInitial(
                showArrow: true,
              ),
              body: (initialized ||
                      snapshot.connectionState == ConnectionState.done)
                  ? Center(
                      child: Container(
                        width: 1024, // Ajusta según tus necesidades
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FittedBox(
                          child: Center(
                              child: Column(children: [
                            SizedBox(
                              // Box where the name is shown
                              height: 50,
                              width: 250,
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    profileList.isNotEmpty
                                        ? profileList[currentIndex].userName
                                        : ' ',
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
                                      size:
                                          38, // Ajusta el tamaño según tus necesidades
                                      color: Colors.white,
                                      semanticLabel:
                                          'Siguiente estudiante', // Cambia el color de la flecha
                                    ),
                                  ),

                                  // Box transparent between the button and the profile picture
                                  const SizedBox(width: 20),

                                  // Profile Picture box
                                  InkWell(
                                    onTap: () {
                                      selectUser(currentIndex);
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
                                        child: Semantics(
                                            label: profileList[currentIndex].userName,
                                            child: imageWidget(currentIndex)),
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
                                      size:
                                          38, // Ajusta el tamaño según tus necesidades
                                      color: Colors.white,
                                      semanticLabel:
                                          'Siguiente estudiante', // Cambia el color de la flecha
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ])),
                        ),
                      ),
                    )
                  : const LoadingDialog());
        });
  }
}
