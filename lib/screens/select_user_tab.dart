import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserTab extends StatefulWidget {
  SelectUserTab({Key? key});

  @override
  _SelectUserTabState createState() => _SelectUserTabState();
}

class _SelectUserTabState extends State<SelectUserTab> {
  List<String> imagenes = [
    'assets/images/ronaldo.png',
    'assets/images/alonso.png',
  ];

  // List with the Id user and the profile picture url
  List<MapEntry<UserModel, String>> profileList = [];

  int numUsers = 0;
  UserModel? selectedUser;

  @override
  void initState() {
    super.initState();
    // Llamar a la función para obtener un usuario específico cuando el widget se inicie
    //_loadUserById(1);
    //_countNumerUsers();

    _getInfoUsers();
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

  // Function that returns the number of users in the DB
  Future<void> _countNumerUsers() async {
    try {
      numUsers = await countUsers();
      print('Number of users: $numUsers');
    } catch (e) {
      print('Error loading user: $e');
      // Manejar el error según sea necesario
    }
  }

  // Function that returns a user from the DB
  Future<void> _loadUserById(int userId) async {
    print("hola");

    try {
      UserModel user = await getUserFromId(userId);
      setState(() {
        selectedUser = user;
      });

      print('User loaded: ${selectedUser?.username}');
    } catch (e) {
      print('Error loading user: $e');
      // Manejar el error según sea necesario
    }
  }

  int currentIndex = 0;

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
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Box transparent between left and the button
                    const SizedBox(width: 10),

                    // Elevated Button to the previous user
                    ElevatedButton(
                      onPressed: currentIndex > 0
                          ? () {
                              setState(() {
                                currentIndex = (currentIndex - 6)
                                    .clamp(0, profileList.length);
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
                              // Manejar el evento de clic aquí
                              print(
                                  'Usuario clickado, número: ${profileList[imageIndex].key.id}');
                            },
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    profileList.isNotEmpty
                                        ? profileList[imageIndex].key.userName
                                        : ' ', // No users available
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
                      onPressed: currentIndex + 6 < imagenes.length
                          ? () {
                              setState(() {
                                currentIndex = (currentIndex + 6)
                                    .clamp(0, imagenes.length);
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
