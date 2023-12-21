import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:appcesible/command/session_command.dart';
import 'package:appcesible/services/media_service.dart';

import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/models/class_model.dart';

// CREATE

Future createUser(UserModel user, String password, File image) async {
  String baseAddress = await getBaseAddress();

  user.idProfileImg = await uploadImage(image);

  List<String> pictoPass = [];
  if (user.userType == 1 && user.loginType == 1) {
    pictoPass = password.split(' ');
  }

  final response = await http.post(
    Uri.http(baseAddress, '/user/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: (user.userType != 1)
      ? jsonEncode(<String, dynamic>{
        'userName': user.userName,
        'passwd': password,
        'pfp': user.idProfileImg,
        'userType': user.userType,
        'idClass': user.idClass,
      })
      : (user.loginType == 0)
        ? jsonEncode(<String, dynamic> {
          'userName': user.userName,
          'pfp': user.idProfileImg,
          'userType': user.userType,
          'idClass': user.idClass,
          'loginType': user.loginType,
          'passwd': password,
          'interactionFormat': user.interactionFormat
        })
        : jsonEncode(<String, dynamic> {
          'userName': user.userName,
          'pfp': user.idProfileImg,
          'userType': user.userType,
          'idClass': user.idClass,
          'loginType': user.loginType,
          'passPart0': int.parse(pictoPass[0]),
          'passPart1': int.parse(pictoPass[1]),
          'passPart2': int.parse(pictoPass[2]),
          'interactionFormat': user.interactionFormat
        })
  );

  if (response.statusCode == 200) {
    print("Created user!");
  } else {
    throw Exception('Failed to create User: ${response.statusCode}');
  }
}

// GET INFO

// Returns all users information
Future<List<UserModel>> getAllUsers(bool getImages) async {
  String baseAddress = await getBaseAddress();

  final response = await http.get(
    Uri.http(baseAddress, '/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(utf8.decode(response.bodyBytes));

    List<UserModel> users = userList.map((json) => UserModel.userFromJSON(json)).toList();
    for (int i = 0; i < users.length && getImages; i++) {
      users[i].image = await downloadImage(users[i].idProfileImg);
    }

    return users;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Makes a HTTP request to get all teachers
//TODO: función para pedir profesores (ahora mismo no hace falta)

// Makes a HTTP request to get all students
Future<List<UserModel>> getAllStudents(bool getImages) async {
  String baseAddress = await getBaseAddress();

  final response = await http.get(
    Uri.http(baseAddress, '/user/student'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(utf8.decode(response.bodyBytes));

    List<UserModel> users = userList.map((json) => UserModel.userFromJSON(json)).toList();
    for (int i = 0; i < users.length && getImages; i++) {
      users[i].image = await downloadImage(users[i].idProfileImg);
    }

    return users;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Makes a HTTP request to get all users except students
Future<List<UserModel>> getAllNoStudent(bool getImages) async {
  String baseAddress = await getBaseAddress();

  final response = await http.get(
    Uri.http(baseAddress, '/user/nostudent'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(utf8.decode(response.bodyBytes));

    List<UserModel> users = userList.map((json) => UserModel.userFromJSON(json)).toList();
    for (int i = 0; i < users.length && getImages; i++) {
      users[i].image = await downloadImage(users[i].idProfileImg);
    }

    return users;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Makes a HTTP request to get a User from the server DB
Future<UserModel> getUserFromId(int id, bool getImage) async {
  String baseAddress = await getBaseAddress();

  final response = await http.get(Uri.http(baseAddress, '/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(utf8.decode(response.bodyBytes));

    UserModel user = UserModel.userFromJSON(json);
    if (getImage) {
      user.image = await downloadImage(user.idProfileImg);
    }

    return user;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Makes a HTTP request to get a Student from the server DB
Future<UserModel> getStudentFromId(int id) async {
  String baseAddress = await getBaseAddress();

  final response = await http.get(Uri.http(baseAddress, '/user/student/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(utf8.decode(response.bodyBytes));

    UserModel student = UserModel.studentFromJSON(json);
    student.image = await downloadImage(student.idProfileImg);

    return student;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Makes a HTTP request to get a Teacher from the server DB
// TODO: función para pedir un profesor dado su id (ahora mismo no hace falta)

Future<Image> getProfileImage(int id) async {
  UserModel user = await getUserFromId(id, true);
  Image img = user.image ?? Image.asset('assets/images/addPicture.png');

  return img;
}

// Returns the list of users in the DB (id and profile picture url)
// Future<List> getInfoUsers(bool getImages) async {
//   List<MapEntry<UserModel, String>> profileList = [];

//   try {
//     List<UserModel> users = await getAllUsers(getImages);

//     for (var user in users) {
//       String photoUrl = "faltaUrl"; /*_getUserPhoto(user.idProfileImg);*/

//       profileList.add(MapEntry(user, photoUrl));
//     }
//   } catch (e) {
//     // Manejar el error según sea necesario
//     throw Exception('Error fetching user list: $e');
//   }

//   return profileList;
// }

// Returns the number of users in the DB
// Future<int> countUsers() async {
//   String baseAddress = await getBaseAddress();

//   final response = await http.get(Uri.http(baseAddress, '/user'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       });

//   if (response.statusCode == 200) {
//     List<dynamic> userList = jsonDecode(utf8.decode(response.bodyBytes));
//     return userList.length;
//   } else {
//     throw Exception('Failed to load User');
//   }
// }

Future<List<ClassModel>> getClasses() async {
  String baseAddress = await getBaseAddress();

  final response = await http.get(Uri.http(baseAddress, '/class'),
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
Future updateUser(UserModel user, String password, File image) async {
  String baseAddress = await getBaseAddress();

  int id = user.id;
  final response = await http.post(
    Uri.http(baseAddress, '/user/$id'),
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
//   final response = await http.get(Uri.http(baseAddress, '/user/$id'),
//       headers: <String, String> {
//         'Content-Type': 'application/json; charset=UTF-8'
//       });
//   if (response.statusCode == 200) {
//     dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
//     UserModel user = UserModel.userFromJSON(json);
//     if (verifyPassword(enteredPassword, user.passwd)) {
//       print("Contraseña correcta");
//       return UserModel.userFromJSON(json);
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
    String baseAddress = await getBaseAddress();

    final response = await http
        .post(
          Uri.http(baseAddress, '/session/login'),
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
      String token = utf8.decode(response.bodyBytes);
      sessionToken(token);
      userLogin(user.id, user.userName, user.userType, -1);

      print('Authentication successful. Token: $token');
      return true;
    } else {
      print('Authentication error. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error on request: $e');
    return false;
  }
}

Future<bool> pictoAuthenticateUser0(
    UserModel user, String enteredPassword, int pos) async {
  try {
    String baseAddress = await getBaseAddress();

    print(pos);
    final response;
    if (pos == 0) {
      response = await http
          .post(
            Uri.http(baseAddress, '/session/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(<String, dynamic>{
              'userName': user.userName,
              'passPart0': enteredPassword,
              'publicKey': "rasfDDFSs",
            }),
          )
          .timeout(const Duration(seconds: 200));
    } else if (pos == 1) {
      response = await http
          .post(
            Uri.http(baseAddress, '/session/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(<String, dynamic>{
              'userName': user.userName,
              'passPart1': enteredPassword,
              'publicKey': "rasfDDFSs",
            }),
          )
          .timeout(const Duration(seconds: 200));
    } else {
      response = await http
          .post(
            Uri.http(baseAddress, '/session/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(<String, dynamic>{
              'userName': user.userName,
              'passPart2': enteredPassword,
              'publicKey': "rasfDDFSs",
            }),
          )
          .timeout(const Duration(seconds: 200));
    }

    if (response.statusCode == 202) {
      String token = utf8.decode(response.bodyBytes);
      sessionToken(token);
      userLogin(user.id, user.userName, user.userType, -1);

      print('Authentication successful. Token: $token');
      return true;
    } else {
      print('Authentication error. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error on request: $e');
    return false;
  }
}

Future<bool> logOutUser() async {
  String baseAddress = await getBaseAddress();

  String token = '';
  await getSessionInformation().then((value) {
    token = value.getString('token') ?? '';
  });

  print('token_out - $token');

  final response = await http.post(
    Uri.http(baseAddress, '/session/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'sessionToken': token,
    }),
  );

  if (response.statusCode == 200) {
    userLogout();
    return true;
  } else {
    print('Could not logout. Status code: ${response.statusCode}');
  }

  return false;
}

void main() async {
  List<dynamic> classes = await getClasses();
  print(classes);
}
