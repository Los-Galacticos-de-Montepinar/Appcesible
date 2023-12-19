import 'package:flutter/material.dart';

class UserModel {
  int id;

  // Login information
  String userName;

  // Profile information
  Image? image;
  int? idProfileImg;
  int userType;
  int idClass;

  // Student information
  int loginType;
  int? letterSize;
  int? interactionFormat;
  
  // Constructor
  UserModel({
    required this.id,
    required this.userName,
    this.image,
    this.idProfileImg,
    required this.userType,
    required this.idClass,
    required this.loginType,
    this.letterSize,
    this.interactionFormat
  });

  // Factory method that creates an User instance from a JSON
  factory UserModel.userFromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      userName: json['userName'] as String,
      idProfileImg: json['pfp'] as int,
      userType: json['userType'] as int,
      idClass: json['idClass'] as int,
      loginType: json['loginType'] as int
    );
  }

  // Factory method that creates an User instance from a JSON
  factory UserModel.studentFromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      userName: json['userName'] as String,
      idProfileImg: json['pfp'] as int,
      userType: json['userType'] as int,
      idClass: json['idClass'] as int,
      loginType: json['loginType'] as int,
      letterSize: json['letterSize'] as int,
      interactionFormat: json['interactionFormat'] as int
    );
  }

  // toString
  @override
  String toString() {
    return 'id: $id, userName: $userName, pfp: $idProfileImg, userType: $userType, idClass: $idClass';
  }
}