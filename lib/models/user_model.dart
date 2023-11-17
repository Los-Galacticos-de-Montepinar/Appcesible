class UserModel {
  int id;

  // Login information
  final String userName;
  //final String _passwd;

  // Profile information
  final int idProfileImg;
  final int userType;
  final int idClass;

  // General information
  final int age;

  // Constructor
  UserModel(
    {required this.id,
    required this.userName,
    //required this.passwd,
    required this.idProfileImg,
    required this.userType,
    required this.idClass,
    required this.age}
  );

  // Factory method that creates an User instance from a JSON
  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as int,
        userName: json['userName'] as String,
        //passwd: json['passwd'] as String,
        idProfileImg: json['pfp'] as int,
        userType: json['userType'] as int,
        idClass: json['idClass'] as int,
        age: json['age'] as int);
  }

  // GET methods
  String get username => userName;
}
