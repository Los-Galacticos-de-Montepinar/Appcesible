import 'dart:convert';
import 'package:http/http.dart' as http;

//Future<UserModel> createUser() async {
//
//}

// Function that makes a HTTP request to get a User from the server DB
Future<UserModel> getUserFromId(int id) async {
  final response = await http.post(
    Uri.http(UserModel.baseAddress, '/user/$id'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic> {
      'name': 'Joestar Johnny',
      'passwd': 'pass11',
      'pfp': 3
    }),
  );

  if (response.statusCode == 200) {
    return UserModel.fromJSON(jsonDecode(response.body));
  }
  else {
    throw Exception('Failed to load User');
  }
}

class UserModel {
  static const String baseAddress = '10.0.2.2:8080';

  int _id;

  // Login information
  final String _userName;
  //final String _passwd;

  // Profile information
  final int _idProfileImg;
  final int _userType;
  final int _idClass;

  // General information
  final int _age;

  // Contructor
  UserModel._defaultConstructor(
    this._id,
    this._userName,
    //this.passwd,
    this._idProfileImg,
    this._userType,
    this._idClass,
    this._age
  );

  // Factory method that creates an User instance from a JSON
  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel._defaultConstructor(
      json["id"] as int,
      json["userName"] as String,
      //json["passwd"] as String,
      json["idProfileImg"] as int,
      json["userType"] as int,
      json["idClass"] as int,
      json["age"] as int
    );
  }

  // GET methods
  String get userName => _userName;
}