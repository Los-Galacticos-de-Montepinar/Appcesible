import 'dart:convert';
import 'package:http/http.dart' as http;

//Future<User> createUser() async {
//
//}

// Function that makes a HTTP request to get a User from the server DB
Future<User> getUserFromId(int id) async {
  final response = await http.get(
    Uri.http(User.baseAddress, '/$id'),
    headers: <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    return User.fromJSON(jsonDecode(response.body));
  }
  else {
    throw Exception('Failed to load User');
  }
}

class User {
  static const String baseAddress = 'localhost:8080';

  final int id;

  // Login information
  final String userName;
  //final String passwd;

  // Profile information
  final int idProfileImg;
  final int userType;
  final int idClass;

  // General information
  final int age;

  // Contructor
  User._defaultConstructor({
    required this.id,
    required this.userName,
    //required this.passwd,
    required this.idProfileImg,
    required this.userType,
    required this.idClass,
    required this.age
  });

  // Factory method that creates an User instance from a JSON
  factory User.fromJSON(Map<String, dynamic> json) {
    return User._defaultConstructor(
      id: json["id"] as int,
      userName: json["userName"] as String,
      //passwd: json["passwd"] as String,
      idProfileImg: json["idProfileImg"] as int,
      userType: json["userType"] as int,
      idClass: json["idClass"] as int,
      age: json["age"] as int
    );
  }
}