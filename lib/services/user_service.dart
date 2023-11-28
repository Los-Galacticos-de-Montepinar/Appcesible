import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/user_model.dart';

String _baseAddress = '10.0.2.2:8080';

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
  }
  else {
    throw Exception('Failed to update User');
  }
}

// Function that makes a HTTP request to get a User from the server DB
Future<UserModel> getUserFromId(int id) async {
  final response = await http.get(Uri.http(_baseAddress, '/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    print(json);
    return UserModel.fromJSON(json);
  }
  else {
    throw Exception('Failed to load User');
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
  }
  else {
    throw Exception('Failed to update User');
  }
}
