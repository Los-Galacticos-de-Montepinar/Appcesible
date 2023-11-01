import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/user_model.dart';

// Function that makes a HTTP request to get a User from the server DB
Future<UserModel> getUserFromId(int id) async {
  final response = await http.get(
    Uri.http(UserModel.baseAddress, '/user/$id'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    print("JSON");
    print(response.body);
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
    Uri.http(UserModel.baseAddress, '/user/$id'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic> {
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