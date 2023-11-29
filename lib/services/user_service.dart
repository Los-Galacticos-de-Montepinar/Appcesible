import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/user_model.dart';

//String baseAdresss = = '192.168.1.136:8080';  // IP ordenador (para usar la app desde el movil)
String baseAddress = 'localhost:8080';

void createUser(UserModel user, String password) async {
  final response = await http.post(
    Uri.http(baseAddress, '/user/new'),
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
  final response = await http.get(Uri.http(baseAddress, '/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    return UserModel.fromJSON(json);
  } else {
    throw Exception('Failed to load User');
  }
}

// Return the number of users in the DB
Future<int> countUsers() async {
  final response = await http.get(Uri.http(baseAddress, '/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    List<dynamic> userList = jsonDecode(response.body);
    return userList.length;
  } else {
    throw Exception('Failed to fetch user list');
  }
}

// Return all users information
Future<List<UserModel>> getAllUsers() async {
  final response = await http.get(Uri.http(baseAddress, '/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

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

void createStep(String media, String description) async {
  final response = await http.post(
    Uri.http(UserModel.baseAddress, '/task/step/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'media': media,
      'order': 1,
      'taskId': 1,
      'desc': description,
    }),
  );

  if (response.statusCode == 200) {
    print("New step created");
  } else {
    throw Exception('Failed to create a step');
  }
}
