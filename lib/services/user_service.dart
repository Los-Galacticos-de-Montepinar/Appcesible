import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/user_model.dart';

// String _baseAddress = '10.0.2.2:8080';      // IP emulador
// String _baseAddress = 'localhost:8080';
String _baseAddress = '192.168.1.42:8080';  // IP ordenador

void createUser(UserModel user, String password) async {
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

// Function that makes a HTTP request to get a User from the server DB
Future<UserModel> getUserFromId(int id) async {
  final response = await http.get(
    Uri.http(_baseAddress, '/user/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    return UserModel.fromJSON(json);
  } else {
    throw Exception('Failed to load User');
  }
}

// Return the number of users in the DB
Future<int> countUsers() async {
  final response = await http.get(
    Uri.http(_baseAddress, '/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(response.body);
    return userList.length;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Return all users information
Future<List<UserModel>> getAllUsers() async {
  final response = await http.get(
    Uri.http(_baseAddress, '/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(response.body);
    return userList.map((json) => UserModel.fromJSON(json)).toList();
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Function that makes a HTTP request to update a User in the server DB
void updateUser(UserModel user, String password) async {
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

// Future<UserModel> authenticateUser(int id, String enteredPassword) async {
//   final response = await http.get(Uri.http(_baseAddress, '/user/$id'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       });
//   if (response.statusCode == 200) {
//     dynamic json = jsonDecode(response.body);
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
    final response = await http.post(
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
      var jsonResponse = await json.decode(json.encode(response.body));
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

Future<bool> pictoAuthenticateUser0(UserModel user, String enteredPassword) async {
  try {
    final response = await http.post(
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
      var jsonResponse = await json.decode(json.encode(response.body));
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