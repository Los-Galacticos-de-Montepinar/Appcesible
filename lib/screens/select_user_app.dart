import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/screens/normal_passw.dart';
import 'package:appcesible/screens/pictograms_passw.dart';
import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserApp extends StatefulWidget {
  SelectUserApp({Key? key});

  @override
  _SelectUserAppState createState() => _SelectUserAppState();
}

class _SelectUserAppState extends State<SelectUserApp> {
  List<String> imagenes = [
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
  ];

  // List with the Id user and the profile picture url
  int currentIndex = 0;
  List<MapEntry<UserModel, String>> profileList = [];

  @override
  void initState() {
    _getInfoUsers();
    super.initState();
    // Llamar a la función para obtener un usuario específico cuando el widget se inicie
  }

  /*// Function that returns the url of the user profile picture
  Future<void> _getUserPhoto(int id) async {
    try {
      UserModel user = await getPhotoUser(id);
      return user.idProfileImg;
    } catch (e) {
      print('Error loading user: $e');
      // Manejar el error según sea necesario
    }
  }*/

  // Function that returns the list of users in the DB (id and profile picture url)
  Future<void> _getInfoUsers() async {
    try {
      List<UserModel> users = await getAllUsers();

      for (var user in users) {
        String photoUrl = "faltaUrl"; /*_getUserPhoto(user.idProfileImg);*/

        profileList.add(MapEntry(user, photoUrl));
      }
    } catch (e) {
      // Manejar el error según sea necesario
      throw Exception('Error fetching user list: $e');
    }
  }

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
              children: <Widget>[
                const SizedBox(height: 80),
                SizedBox(
                  width: 160,
                  height: 50,
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
                const SizedBox(height: 65),
                Column(children: [
                  SizedBox(
                    // Box where the name is shown
                    height: 50,
                    width: 250,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          profileList.isNotEmpty
                              ? profileList[currentIndex].key.userName
                              : ' ', // No users avaliable
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
                            setState(() {
                              currentIndex = (currentIndex - 1) % (profileList.length - 1);
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
                            size: 38, // Ajusta el tamaño según tus necesidades
                            color: Colors.white, // Cambia el color de la flecha
                          ),
                        ),

                        // Box transparent between the button and the profile picture
                        const SizedBox(width: 20),

                        // Profile Picture box
                        InkWell(
                          onTap: () {
                            UserModel selUser = profileList[currentIndex].key;
                            // Maneja la acción al hacer clic en la imagen.
                            print('Usuario clickado, número: ${selUser.id}');

                            if (selUser.userType == 1) {  // Falta la condición para modo de visualización
                              Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                                  return PictoPassw();
                                })
                              );
                            }
                            else {
                              Navigator.of(context)
                                .push(MaterialPageRoute(builder: (BuildContext context) {
                                  return const Login();
                                })
                              );
                            }
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
                              child:
                                  _imageWidget(image: imagenes[currentIndex]),
                            ),
                          ),
                        ),

                        // Box transparent between the button and the profile picture
                        const SizedBox(width: 20),

                        // Elevated Button to the next user
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentIndex = (currentIndex + 1) % (profileList.length - 1);
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