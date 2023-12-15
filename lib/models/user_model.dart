import 'dart:io';

class UserModel {
  int id;

  // Login information
  String userName;

  // Profile information
  File? image;
  int? idProfileImg;
  int userType;
  int idClass;
  
  // Constructor
  UserModel({
    required this.id,
    required this.userName,
    this.idProfileImg,
    required this.userType,
    required this.idClass
  });

  // Factory method that creates an User instance from a JSON
  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      userName: json['userName'] as String,
      idProfileImg: json['pfp'] as int,
      userType: json['userType'] as int,
      idClass: json['idClass'] as int
    );
  }

  // toString
  @override
  String toString() {
    return 'id: $id, userName: $userName, pfp: $idProfileImg, userType: $userType, idClass: $idClass';
  }
}