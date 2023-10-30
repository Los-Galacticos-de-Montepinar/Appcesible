import 'dart:convert';
import 'package:http/http.dart' as http;

Future<User> getUserFromId(int id) async {
  final response = await http.get(
    Uri.http(User._baseAddress, '/$id'),
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
  static const String _baseAddress = 'localhost:8080';

  final int id;

  // Login info
  final String userName;
  final String passwd;

  // Profile info
  final int idProfileImg;
  final int userType;
  final int idClass;

  // General info
  final int age;

  User({
    required this.id,
    required this.userName,
    required this.passwd,
    required this.idProfileImg,
    required this.userType,
    required this.idClass,
    required this.age
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json["id"] as int,
      userName: json["userName"] as String,
      passwd: json["passwd"] as String,
      idProfileImg: json["idProfileImg"] as int,
      userType: json["userType"] as int,
      idClass: json["idClass"] as int,
      age: json["age"] as int
    );
  }
}