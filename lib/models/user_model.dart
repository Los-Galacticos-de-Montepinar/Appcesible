class UserModel {
  int id;

  // Login information
  String userName;
  //String _passwd;

  // Profile information
  int idProfileImg;
  int userType;
  int idClass;

  // Constructor
  UserModel({
    required this.id,
    required this.userName,
    //required this.passwd,
    required this.idProfileImg,
    required this.userType,
    required this.idClass,

  });

  // Factory method that creates an User instance from a JSON
  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as int,
        userName: json['userName'] as String,
        //passwd: json['passwd'] as String,
        idProfileImg: json['pfp'] as int,
        userType: json['userType'] as int,
        idClass: json['idClass'] as int,);
  }

  // GET methods
  String get username => userName;
}
