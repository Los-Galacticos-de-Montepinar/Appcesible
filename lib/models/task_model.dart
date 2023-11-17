class TaskModel {
  int id;

  // General information
  final String title;
  final String description;
  final int idPicto;

  // Constructor
  TaskModel(
    {required this.id,
    required this.title,
    required this.description,
    required this.idPicto}
  );

  // Factory method that creates an User instance from a JSON
  factory TaskModel.fromJSON(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['desc'] as String,
      idPicto: json[''] as int);
  }
}
