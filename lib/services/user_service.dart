import 'package:appcesible/models/class_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/user_model.dart';

// String _baseAddress = '10.0.2.2:8080';      // IP emulador
// String _baseAddress = '192.168.1.42:8080';
String _baseAddress = 'localhost:8080'; // IP ordenador

// CREATE

Future createUser(UserModel user, String password) async {
  final response = await http.post(
    Uri.http(_baseAddress, '/user/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'userName': user.userName,
      'passwd': password,
      'pfp': user.idProfileImg,
      'idClass': user.idClass,
      'userType': user.userType,
      'date': '20/20/20'
    }),
  );

  if (response.statusCode == 200) {
    print("Updated user");
  } else {
    throw Exception('Failed to update User');
  }
}

// GET INFO

// Returns all users information
Future<List<UserModel>> getAllUsers() async {
  final response = await http.get(Uri.http(_baseAddress, '/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(utf8.decode(response.bodyBytes));
    return userList.map((json) => UserModel.fromJSON(json)).toList();
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Makes a HTTP request to get all teachers
//TODO: función para pedir profesores (ahora mismo no hace falta)

// Makes a HTTP request to get all students
//TODO: función para pedir alumnos (ahora mismo no hace falta)

// Makes a HTTP request to get a User from the server DB
Future<UserModel> getUserFromId(int id) async {
  final response = await http.get(Uri.http(_baseAddress, '/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
    return UserModel.fromJSON(json);
  } else {
    throw Exception('Failed to load User');
  }
}

// Returns the url of the user profile picture
// Future getUserPhoto(int id) async {
//   try {
//     UserModel user = await getPhotoUser(id);
//     return user.idProfileImg;
//   } catch (e) {
//     print('Error loading user: $e');
//     // Manejar el error según sea necesario
//   }
// }

// Returns the list of users in the DB (id and profile picture url)
Future<List> getInfoUsers() async {
  List<MapEntry<UserModel, String>> profileList = [];

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

  return profileList;
}

// Returns the number of users in the DB
Future<int> countUsers() async {
  final response = await http.get(Uri.http(_baseAddress, '/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(utf8.decode(response.bodyBytes));
    return userList.length;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

Future<List<ClassModel>> getClasses() async {
  final response = await http.get(Uri.http(_baseAddress, '/class'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    List<dynamic> classList = jsonDecode(utf8.decode(response.bodyBytes));
    return classList.map((json) => ClassModel.fromJSON(json)).toList();
  } else {
    throw Exception('Failed to fetch classes');
  }
}

// UPDATE

// Makes a HTTP request to update a User in the server DB
Future updateUser(UserModel user, String password) async {
  int id = user.id;
  final response = await http.post(
    Uri.http(_baseAddress, '/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'name': user.userName,
      'passwd': password,
      'pfp': user.idProfileImg
    }),
  );

  if (response.statusCode == 200) {
    print("Updated user");
  } else {
    throw Exception('Failed to update User');
  }
}

// DELETE

// TODO: función para eliminar usuarios

// AUTHENTICATION

// Future<UserModel> authenticateUser(int id, String enteredPassword) async {
//   final response = await http.get(Uri.http(_baseAddress, '/user/$id'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       });
//   if (response.statusCode == 200) {
//     dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
//     UserModel user = UserModel.fromJSON(json);
//     if (verifyPassword(enteredPassword, user.passwd)) {
//       print("Contraseña correcta");
//       return UserModel.fromJSON(json);
//     } else {
//       print(enteredPassword.toString());
//       print(user.passwd.toString());
//       throw Exception('Contraseña incorrecta');
//     }
//   } else {
//     print('object');
//     throw Exception('Failed to load User');
//   }
// }

// bool verifyPassword(String enteredPassword, String dbPassword) {
//   return enteredPassword == dbPassword;
// }

Future<bool> authenticateUser(UserModel user, String enteredPassword) async {
  try {
    final response = await http
        .post(
          Uri.http(_baseAddress, '/session/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            'userName': user.userName,
            'passwd': enteredPassword,
            'publicKey': 123,
          }),
        )
        .timeout(const Duration(seconds: 200));

    if (response.statusCode == 200) {
      var jsonResponse =
          await json.decode(json.encode(utf8.decode(response.bodyBytes)));
      print('Autenticacion exitosa. Token: $jsonResponse');
      return true;
    } else {
      print(
          'Error en la autenticación. Código de estado: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error durante la solicitud: $e');
    return false;
  }
}

Future<bool> pictoAuthenticateUser0(
    UserModel user, String enteredPassword) async {
  try {
    final response = await http
        .post(
          Uri.http(_baseAddress, '/session/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            'userName': user.userName,
            'passPart0': enteredPassword,
            'publicKey': 123,
          }),
        )
        .timeout(const Duration(seconds: 200));

    if (response.statusCode == 200) {
      var jsonResponse =
          await json.decode(json.encode(utf8.decode(response.bodyBytes)));
      print('Autenticacion exitosa. Token: $jsonResponse');
      return true;
    } else {
      print(
          'Error en la autenticación. Código de estado: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error durante la solicitud: $e');
    return false;
  }
}

void main() async {
  List<dynamic> classes = await getClasses();
  print(classes);
}
