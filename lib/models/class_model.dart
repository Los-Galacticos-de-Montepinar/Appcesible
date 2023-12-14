class ClassModel {
  int id;
  String className;

  ClassModel({
    required this.id,
    required this.className
  });

  // Factory method that creates an User instance from a JSON
  factory ClassModel.fromJSON(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as int,
      className: json['className'] as String,
    );
  }
}
